# 🕹️ Top-Down Controller for Godot

A custom-built top-down character controller made from scratch in **Godot Engine**. This controller allows for fluid WASD movement and real-time aiming and attacking using the mouse. Perfect as a foundation for twin-stick shooters, action RPGs, or top-down adventure games.

## 🚀 Features

- ✅ Smooth WASD movement
- ✅ Character rotates to face the mouse pointer
- ✅ Mouse click attack support
- ✅ Lightweight and beginner-friendly
- ✅ Easy to extend for combat systems, animations, etc.

## 🧠 How It Works

- The character's position is controlled using the **WASD** keys.
- The character's rotation constantly updates to face the **mouse pointer**, giving a natural aiming mechanic.
- **Left Mouse clicks** trigger an `attack()` function that you can customize to your liking (e.g., melee swing, projectile launch, etc.).

## 📸 Screenshots / Demo

Attack Animation -
https://github.com/ananthakrishnantm/TopDown3D_Godot/blob/main/screenshots/AttackAnimation.gif?raw=true

## 🛠️ Built With

- [Godot Engine](https://godotengine.org/) (version 4.4)

## 📂 Project Structure

````plaintext
TopDownController/
├── animation/          # Animation resources
├── character/          # Character sprites or scene parts
├── main.tscn
├── player.tscn
├── player.gd
├── README.md
└── readme.txt


## ▶️ How to Use

1. Clone or download this repo.
2. Open the project in [Godot Engine](https://godotengine.org/).
3. Launch `main.tscn` to see it in action.
4. Drop `player.tscn` into your own scene to use the controller in your game.

```bash
git clone https://github.com/yourusername/topdown-controller-godot.git


````
