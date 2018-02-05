# Survive

Survive is a turn-based programming game where you write an AI that competes
against other AIs for survival on a 2D grid.

## Rules

Survive is played on a grid, similar to [Conway's Game of Life][1]. You write an
AI that takes the form of a unicellular life form. On every turn your AI:

  - Receives signals from surrounding cells
  - Decides:
    - Which signals to send back to surrounding cells
    - What action to take

### Signals

#### nosig

No signal.

#### brace

Defensive signal, blocking offensive moves by adjacent AIs.

#### give

Used to send energy from this cell to an adjacent cell.

#### vamp

Used to take energy from an adjacent cell and give it to this cell.


### Actions

#### north, east, south, or west

Move in the specified direction.

#### suicide

This cell dies.


### Special

#### kill

If a cell throws an exception, or returns invalid action and signal output, the
cell will be killed by the simulation.

### Signaling costs and gains

Signaling works in pairs of an outgoing signal, and an incoming signal. Every
pair has a cost and associated gain.

| out   | cost | in     | gain |
| ------|------|--------|------|
| nosig | +0.1 | (none) | +0.1 |
| nosig | +0.1 | nosig  | +0.1 |
| nosig | +0.1 | brace  | +0.1 |
| nosig | +0.1 | give   | +0.2 |
| nosig | +0.1 | vamp   | -0.4 |
| ------|------|--------|------|
| vamp  | -0.2 | (none) |  0.0 |
| vamp  | -0.2 | nosig  | +0.4 |
| vamp  | -0.2 | brace  | +0.0 |
| vamp  | -0.2 | give   | +0.6 |
| vamp  | -0.2 | vamp   |  0.0 |
| ------|------|--------|------|
| brace | -0.1 | (none) |  0.0 |
| brace | -0.1 | nosig  |  0.0 |
| brace | -0.1 | brace  |  0.0 |
| brace | -0.1 | give   |  0.0 |
| brace | -0.1 | vamp   |  0.0 |
| ------|------|--------|------|
| give  | -0.2 | (none) |  0.0 |
| give  | -0.2 | nosig  |  0.0 |
| give  | -0.2 | brace  |  0.0 |
| give  | -0.2 | give   |  0.0 |
| give  | -0.2 | vamp   |  0.0 |

  [1]: https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
