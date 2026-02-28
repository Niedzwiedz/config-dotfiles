package main

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"sort"
	"strings"
	"time"

	tea "github.com/charmbracelet/bubbletea"
	"github.com/charmbracelet/lipgloss"
)

// ── config definitions ───────────────────────────────────────────────────────

type configDef struct {
	name    string
	current string
	glob    string
	isDir   bool
}

var configs = []configDef{
	{"ghostty", "~/.config/ghostty", "~/.config/ghostty.*.bak", true},
	{"nvim", "~/.config/nvim", "~/.config/nvim.*.bak", true},
	{"tmux", "~/.tmux.conf", "~/.tmux.conf.*.bak", false},
	{"skills", "~/.claude/skills", "~/.claude/skills.*.bak", true},
}

// ── helpers ──────────────────────────────────────────────────────────────────

func expandHome(p string) string {
	if strings.HasPrefix(p, "~/") {
		h, _ := os.UserHomeDir()
		return filepath.Join(h, p[2:])
	}
	return p
}

func listVersions(cfg configDef) []string {
	matches, _ := filepath.Glob(expandHome(cfg.glob))
	sort.Sort(sort.Reverse(sort.StringSlice(matches)))
	return matches
}

func formatVersion(path string) string {
	base := filepath.Base(path)
	for _, p := range strings.Split(base, ".") {
		if len(p) == 15 && p[8] == '_' {
			t, err := time.Parse("20060102_150405", p)
			if err == nil {
				return t.Format("2006-01-02  15:04:05")
			}
		}
	}
	return base
}

// ── model ────────────────────────────────────────────────────────────────────

const (
	paneConfig  = 0
	paneVersion = 1
)

type model struct {
	pane       int
	configIdx  int
	versions   []string
	versionIdx int
	status     string
	isErr      bool
	width      int
	height     int
}

func newModel() model {
	return model{versions: listVersions(configs[0])}
}

// ── messages & commands ──────────────────────────────────────────────────────

type restoredMsg struct {
	name string
	ver  string
	err  error
}

func restore(cfg configDef, ver string) tea.Cmd {
	return func() tea.Msg {
		cur := expandHome(cfg.current)
		var err error
		if cfg.isDir {
			if err = os.RemoveAll(cur); err == nil {
				err = exec.Command("cp", "-r", ver, cur).Run()
			}
		} else {
			err = exec.Command("cp", ver, cur).Run()
		}
		return restoredMsg{cfg.name, filepath.Base(ver), err}
	}
}

// ── update ───────────────────────────────────────────────────────────────────

func (m model) Init() tea.Cmd { return nil }

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {
	case tea.WindowSizeMsg:
		m.width, m.height = msg.Width, msg.Height

	case restoredMsg:
		if msg.err != nil {
			m.status = fmt.Sprintf("error: %v", msg.err)
			m.isErr = true
		} else {
			m.status = fmt.Sprintf("✓  restored %s from %s", msg.name, msg.ver)
			m.isErr = false
		}

	case tea.KeyMsg:
		m.status = ""
		switch msg.String() {
		case "q", "ctrl+c":
			return m, tea.Quit

		case "esc":
			if m.pane == paneVersion {
				m.pane = paneConfig
			} else {
				return m, tea.Quit
			}

		case "j", "down":
			if m.pane == paneConfig {
				if m.configIdx < len(configs)-1 {
					m.configIdx++
					m.versions = listVersions(configs[m.configIdx])
					m.versionIdx = 0
				}
			} else {
				if m.versionIdx < len(m.versions)-1 {
					m.versionIdx++
				}
			}

		case "k", "up":
			if m.pane == paneConfig {
				if m.configIdx > 0 {
					m.configIdx--
					m.versions = listVersions(configs[m.configIdx])
					m.versionIdx = 0
				}
			} else {
				if m.versionIdx > 0 {
					m.versionIdx--
				}
			}

		case "enter", " ", "l":
			if m.pane == paneConfig {
				m.pane = paneVersion
				m.versionIdx = 0
			} else if msg.String() == "enter" && len(m.versions) > 0 {
				return m, restore(configs[m.configIdx], m.versions[m.versionIdx])
			}

		case "h":
			if m.pane == paneVersion {
				m.pane = paneConfig
			}
		}
	}
	return m, nil
}

// ── view ─────────────────────────────────────────────────────────────────────

var (
	accent  = lipgloss.Color("2")
	dim     = lipgloss.Color("8")
	errCol  = lipgloss.Color("1")

	titleStyle     = lipgloss.NewStyle().Bold(true).MarginBottom(1)
	cursorOn       = lipgloss.NewStyle().Bold(true).Foreground(accent)
	cursorOff      = lipgloss.NewStyle().Foreground(dim)
	dimStyle       = lipgloss.NewStyle().Foreground(dim)
	statusOkStyle  = lipgloss.NewStyle().Foreground(accent)
	statusErrStyle = lipgloss.NewStyle().Foreground(errCol)
	helpStyle      = lipgloss.NewStyle().Foreground(dim)

	borderActive = lipgloss.NewStyle().
			Border(lipgloss.RoundedBorder()).
			BorderForeground(accent).
			Padding(0, 1)

	borderInactive = lipgloss.NewStyle().
			Border(lipgloss.RoundedBorder()).
			BorderForeground(dim).
			Padding(0, 1)
)

func (m model) View() string {
	panelH := len(m.versions) + 3
	if len(configs)+3 > panelH {
		panelH = len(configs) + 3
	}
	if panelH < 6 {
		panelH = 6
	}

	leftW := 12
	rightW := 36
	if m.width > 0 {
		rightW = m.width - leftW - 10
		if rightW < 24 {
			rightW = 24
		}
	}

	// left panel
	rows := []string{titleStyle.Render("configs")}
	for i, cfg := range configs {
		if i == m.configIdx {
			cur := cursorOn
			if m.pane != paneConfig {
				cur = cursorOff
			}
			rows = append(rows, cur.Render("▸ "+cfg.name))
		} else {
			rows = append(rows, "  "+cfg.name)
		}
	}
	leftStyle := borderInactive.Width(leftW).Height(panelH)
	if m.pane == paneConfig {
		leftStyle = borderActive.Width(leftW).Height(panelH)
	}
	left := leftStyle.Render(strings.Join(rows, "\n"))

	// right panel
	rows = []string{titleStyle.Render("versions — " + configs[m.configIdx].name)}
	if len(m.versions) == 0 {
		rows = append(rows, dimStyle.Render("no backups found"))
	} else {
		for i, ver := range m.versions {
			if i == m.versionIdx {
				cur := cursorOn
				if m.pane != paneVersion {
					cur = cursorOff
				}
				rows = append(rows, cur.Render("▸ "+formatVersion(ver)))
			} else {
				rows = append(rows, "  "+formatVersion(ver))
			}
		}
	}
	rightStyle := borderInactive.Width(rightW).Height(panelH)
	if m.pane == paneVersion {
		rightStyle = borderActive.Width(rightW).Height(panelH)
	}
	right := rightStyle.Render(strings.Join(rows, "\n"))

	// status bar
	var bar string
	if m.status != "" {
		if m.isErr {
			bar = statusErrStyle.Render(m.status)
		} else {
			bar = statusOkStyle.Render(m.status)
		}
	} else if m.pane == paneConfig {
		bar = helpStyle.Render("j/k navigate  l/enter/space select  q quit")
	} else {
		bar = helpStyle.Render("j/k navigate  enter restore  h/esc back")
	}

	return lipgloss.JoinHorizontal(lipgloss.Top, left, right) + "\n" + bar
}

// ── main ─────────────────────────────────────────────────────────────────────

func main() {
	p := tea.NewProgram(newModel(), tea.WithAltScreen())
	if _, err := p.Run(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
