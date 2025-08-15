# State Machine | ANTIPIXEL
## State logic made easy!

*(Download the [documentation](https://github.com/AntipixelGames/antipixel-state-machine/blob/main/State%20Machine%20Antipixel%20Godot%20Documentation.pdf) for **free** to learn everything about it)*

This tool for Godot 4 lets you create state machines in a clean and intuitive way using the scene tree. Each state is a child node, giving you a modular, visual, and scalable way to manage behaviors, UI, animations, scene transitions, and any kind of game logic.

Personally, I consider this to be my **favorite and most important plugin**. I’m offering it for free because I truly believe that structuring your project around state machines from the beginning will save you time, prevent bugs, and help you stay organized, no matter the scale or genre of your game. 

### 🔎 Code Sample

```
# Transition
machine.change("state_id")
# Signals
machine.state_entered.connect(_on_state_entered)
machine.state_exited.connect(_on_state_exited)
```

### 🚀 Key Features

- **Node-Based Design**: Define and manage states as child nodes in your scene.
- **Clean**: Switch states with just one line of code.
- **Scalable**: Keep your logic separated and easy to manage.
- **Customizabe**: Create specific logic by building custom states.
- **Automatic Callbacks**: Each state supports *_enter()*, *_exit()*.
- **Versatile**: Works perfectly for animations, UI, enemies, dialogues, and scenes.

### 💡 Perfect For

- Developers who want structure and clarity from day one.
- Scene and game mode transitions.
- Dynamic user interfaces and menu systems.
- Complex character, enemy, or boss behaviors.
- Projects that need a solid and maintainable logic foundation.

### 🧰 Includes

- Source code.
- Example scene.
- Clear documentation.

### ❤️ Support

If you found this asset useful, please consider a donation to help me continue creating. No matter the amount, every contribution counts. **Thank you all so much!**

### 👉 Check out all my other assets [here](https://antipixel-games.itch.io/)
