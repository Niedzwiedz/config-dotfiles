---
name: learning-planner
description: >
  Use when the user wants to plan a learning project around coding concepts.
  Triggers: "plan a project", "I want to learn X", "create a learning plan",
  "help me explore concept", "design a project to learn". Output is a markdown
  file describing the project, concepts covered, and learning goals.
---

# Learning Planner Skill

Design hands-on coding projects that teach specific concepts through practice.

## Goal

Create a structured lesson plan as a markdown file that:
- Defines a concrete, buildable project
- Maps each project phase to specific concepts the user will learn
- Keeps scope realistic and focused

## Process

### 1. Understand What to Learn

Ask the user (if not already clear):
- What concepts or technologies do they want to explore?
- What is their current experience level with this topic?
- How much time do they want to invest (small/medium/large project)?
- Any preferred language or framework?

Do not ask all these at once. If the request is clear enough, infer reasonable defaults and proceed.

### 2. Design the Project

Choose a project that:
- Is concrete and completable (has a clear "done" state)
- Naturally exercises the target concepts — don't force concepts in
- Has a satisfying outcome the user can show or use
- Scales to the right complexity for their level
- Is NOT a tutorial clone (no "build a todo app" unless specifically requested)

Good project ideas feel slightly unconventional but immediately understandable:
- "a terminal tool that..." instead of "a CRUD app"
- "a script that processes..." instead of "a REST API"
- Domain can be fun: games, tools, simulations, visualizations

### 3. Write the Plan File

Save the plan to a markdown file. Default location: `~/lessons/<project-name>.md`
Ask the user if they want a different location.

The file must include:

```markdown
# [Project Title]

## What You're Building
[2-3 sentences. What does it do? What can the user demo at the end?]

## Concepts You'll Learn
[Bulleted list of concepts, grouped if they're related]

## Prerequisites
[What they should already know. Be honest — don't list basics unless relevant.]

## Project Phases

### Phase 1: [Name]
**Goal:** [What works at end of this phase]
**Concepts introduced:** [List]
**Tasks:**
- [ ] Task 1
- [ ] Task 2
...

### Phase 2: [Name]
...

## Stretch Goals (Optional)
[2-3 extensions if they want to go deeper]

## Notes
[Any key tips, gotchas, or resources worth mentioning]
```

### 4. Summarize for the User

After writing the file, briefly summarize:
- What the project is
- How many phases and approximately how involved
- Where the file was saved
- Suggest they use the `teacher` skill to guide implementation

## Rules

- Do not write any project code — planning only
- Phases should build on each other; nothing should be throwaway
- Each phase should be completable in one focused session
- Be honest about difficulty — don't undersell complexity
- Prefer fewer, deeper concepts over a shallow survey of many
