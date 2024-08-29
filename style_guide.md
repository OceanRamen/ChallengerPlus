# Lua Mod Style Guidelines

## 1. **General Naming Conventions**

- **Variables**

  - Use descriptive, meaningful names.
  - Use `snake_case` for variable names.
  - Prefix boolean variables with `is_`, `has_`, or `can_` to indicate their nature.
  - Example: `player_health`, `is_active`, `has_permission`.

- **Constants**

  - Use `UPPER_CASE` with words separated by underscores.
  - Example: `MAX_PLAYERS`, `DEFAULT_SPEED`.

- **Functions**

  - Use `camelCase` for function names.
  - Start function names with a verb to indicate action.
  - Example: `getPlayerInfo()`, `loadData()`, `updateScore()`.

- **Classes**

  - Use `PascalCase` for class names.
  - Keep class names singular.
  - Example: `Player`, `GameManager`, `InventoryItem`.

- **Modules**

  - Use `snake_case` for module names.
  - Keep module names short and descriptive.
  - Example: `game_manager.lua`, `player_data.lua`.

- **File Names**
  - Use `snake_case` for file names.
  - Ensure file names are descriptive and indicate their purpose.
  - Example: `config.lua`, `utils.lua`, `enemy_ai.lua`.

## 2. **Code Structure**

- **Indentation**

  - Use 2 spaces per indentation level.
  - Avoid tabs; stick to spaces.

- **Line Length**

  - Keep lines to a maximum of 80 characters.
  - If a line exceeds this, consider breaking it up for readability.

- **Comments**

  - Use comments to explain the purpose of code blocks or complex logic.
  - For single-line comments, use `--`.
  - For multi-line comments, use `--[[ ... ]]`.
  - Example:

    ```lua
    -- Initialize the player with default settings
    player = {
        health = 100,
        speed = 5
    }
    ```

- **Function Documentation**

  - Provide a brief description of the function’s purpose, its parameters, and its return value.
  - Example:

    ```lua
    --[[
    Calculates the score for the player.
    @param level The current level of the player.
    @param timeTaken The time taken to complete the level.
    @return The calculated score.
    ]]
    function calculateScore(level, timeTaken)
        -- Function logic here
    end
    ```

- **Whitespace**
  - Use one blank line between functions.
  - Avoid unnecessary blank lines within functions.

## 3. **Coding Practices**

- **Error Handling**

  - Always check for errors and handle them gracefully.
  - Use `assert()` or custom error messages where appropriate.
  - Example:

    ```lua
    local file = io.open("config.txt", "r")
    assert(file, "Failed to open config.txt")
    ```

- **Avoid Global Variables**

  - Keep variables local to avoid polluting the global namespace.
  - Use `local` for variable declaration.
  - Example:

    ```lua
    local playerName = "JohnDoe"
    ```

- **Consistent Return Statements**

  - Always use `return` at the end of functions that are supposed to return a value.
  - Example:

    ```lua
    function calculateSum(a, b)
        return a + b
    end
    ```

- **Modular Code**

  - Break down large scripts into smaller, manageable modules.
  - Each module should handle a specific functionality or feature.

- **Use of Tables**

  - Use tables to group related data.
  - Follow the naming conventions for table keys.
  - Example:

    ```lua
    local player = {
        name = "JohnDoe",
        health = 100,
        inventory = {}
    }
    ```

- **Loops and Conditionals**

  - Use concise and readable loop/conditional structures.
  - Example:

    ```lua
    for i = 1, 10 do
        print(i)
    end

    if player.health <= 0 then
        gameOver()
    end
    ```

## 4. **Version Control**

- **Commit Messages**

  - Write clear and descriptive commit messages.
  - Use the imperative mood: “Fix bug” instead of “Fixed bug”.
  - Include references to issues or tasks if applicable.

- **Branch Naming**
  - Use `kebab-case` for branch names.
  - Prefix branches with the type of work: `feature/`, `bugfix/`, `hotfix/`.
  - Example: `feature/new-game-mode`, `bugfix/player-respawn`.
