# 🌿 Anubhuti

**Anubhuti** (अनुभूति) means *feeling* or *sensation* in Hindi.  
This app is a calm space for you to sit with nature sounds, breathe, and write down whatever you're feeling — no pressure, no judgment.

[![GitHub](https://img.shields.io/badge/GitHub-Anubhuti-2D6A4F?style=for-the-badge&logo=github)](https://github.com/Vineetagrawal2005/Anubhuti)

---

## 📲 Download

| Platform | Link |
|---|---|
| 📦 APK (Android) | [Download from GitHub Releases](https://github.com/Vineetagrawal2005/Anubhuti/releases/latest) |
| 💻 Source Code | [github.com/Vineetagrawal2005/Anubhuti](https://github.com/Vineetagrawal2005/Anubhuti) |

> To install the APK, download it to your Android phone and follow the steps in the Install section below.

---

## 📱 What Does This App Do?

Anubhuti is a **mindfulness and emotion journaling app**. Here's what it lets you do:

- 🎵 **Listen to calming nature sounds** — forest, rain, ocean, night wind, and more
- ✍️ **Write about how you feel** while the sound plays in the background
- 📖 **Read your past entries** anytime to see how you've grown
- 🌙 **Switch between light and dark mode** based on your mood

Think of it like a peaceful corner where you can pause, breathe, and express yourself.

---

## 🚀 How to Install

### Option 1 — Install the APK directly (Android)

1. Download the **Anubhuti.apk** file to your Android phone
2. Open your phone's **File Manager** and find the APK
3. Tap it — your phone may ask *"Allow install from unknown sources"* → tap **Allow**
4. Tap **Install** and wait a few seconds
5. Open **Anubhuti** from your home screen — done! 🎉

> ⚠️ This app is not on the Play Store yet. The APK is safe to install manually.

---

## 🗺️ How to Use the App

### Step 1 — Pick a sound (Home Screen)
When you open the app, you'll see a scrollable list of **ambience cards** — each one is a different nature sound with a unique color.

Scroll left or right to browse:

| Ambience | Sound | Feeling |
|---|---|---|
| 🌲 Forest Focus | Rustling leaves, birds | Grounded, present |
| 🌧️ Rain Calm | Rain on glass, soft thunder | Letting go, surrender |
| 🌊 Ocean Reset | Waves on pebbles | Clarity, release |
| 🌙 Night Wind | Crickets, gentle wind | Sleepy, safe |
| 🌫️ Morning Mist | Single bird, dew drops | Gentle awakening |
| 🌳 Deep Forest | Forest stream, silence | Deep inner quiet |

You can also **search by name** or **filter by tag** (Focus / Calm / Reset / Sleep).

---

### Step 2 — Start your session (Player Screen)
Tap any card to open the player. The sound starts playing automatically.

- ⏸️ Tap the **circle button** to pause or resume the sound
- ⏱️ A timer counts how long you've been in the session
- ✍️ Write freely in the text box below — what are you feeling right now?

When you're done:
- Tap **Save** — your entry gets saved with the time, color, and your words
- Tap **Cancel** — exits without saving

---

### Step 3 — Read past entries (History Screen)
Tap **History** in the bottom bar to see all your saved sessions.

Each card shows the color of the ambience you used. Tap any card to read what you wrote. You can also **delete** entries you no longer want.

---

## 🌗 Light & Dark Mode

Tap the **toggle switch** in the top right corner of any screen to switch between light and dark mode — whichever feels more comfortable for you.

---

## 🛠️ Built With

This app was built using:

- **Flutter** — the framework that makes it work on Android
- **just_audio** — plays the nature sounds
- **Hive** — saves your journal entries locally on your phone (no internet needed)
- **Provider** — manages the app's state and theme

All your data stays **on your device**. Nothing is sent to any server.

---

## 📂 Project Structure (for developers)

```
lib/
├── core/
│   ├── Provider/
│   │   ├── Ambience_provider.dart   # manages current sound selection
│   │   └── Theme_Provider.dart      # manages light/dark mode
│   └── theme/
│       └── Theme_Data.dart          # light and dark theme colors
├── data/
│   ├── model/
│   │   └── Journel.dart             # journal entry data model
│   └── Repository/
│       ├── Ambidence_repo.dart      # loads ambience from JSON
│       ├── Journel_Repo.dart        # saves/reads journal from Hive
│       └── Play_Repo.dart           # controls audio playback
├── page/
│   ├── Splash_Screen.dart           # opening screen
│   ├── Anubhuti.dart                # main screen with bottom nav
│   ├── Home_Screen.dart             # browse and pick ambience
│   ├── Player_Screen.dart           # play sound + write journal
│   ├── History_Screen.dart          # view past entries
│   └── Journey_Reading_Screen.dart  # read a single past entry
├── widget/
│   └── widget.dart                  # reusable UI components
assets/
├── ambiences.json                   # all ambience data
├── audio/                           # mp3 sound files
└── icon/                            # app icons
```

---

## 🎵 Audio Files Needed

Place these files inside `assets/audio/`:

```
forest_focus.mp3
rain_calm.mp3
ocean_reset.mp3
night_wind.mp3
morning_mist.mp3
deep_forest.mp3
```

Free nature sounds can be downloaded from [pixabay.com/sound-effects](https://pixabay.com/sound-effects) or [freesound.org](https://freesound.org).

---

## 🧑‍💻 Run Locally (for developers)

```bash
# 1. Clone the project
git clone https://github.com/Vineetagrawal2005/Anubhuti.git
cd anubhuti

# 2. Install dependencies
flutter pub get

# 3. Generate Hive adapters
flutter pub run build_runner build

# 4. Run the app
flutter run
```

Requires Flutter SDK 3.10 or above.


https://github.com/user-attachments/assets/bb98d9a9-ee7e-48f8-9a8a-56e9443f163b


---
## Images Of AnubhutiApp
<img width="250" alt="WhatsApp Image" src="https://github.com/user-attachments/assets/08df0480-5b28-407f-8487-29170a06b59c" />
<img width="250" alt="WhatsApp Image" src="https://github.com/user-attachments/assets/f5bc525b-2db3-4523-a0a3-773b797a4b02" />
<img width="250" alt="WhatsApp Image" src="https://github.com/user-attachments/assets/efa770fc-d8d3-48af-9ef7-3e9390d583c4" />
<img width="250" alt="WhatsApp Image" src="https://github.com/user-attachments/assets/d4480ed9-af92-4698-b433-d113c0c50b68" />
<img width="250" alt="WhatsApp Image" src="https://github.com/user-attachments/assets/6c92eaa0-6c57-4adb-851f-766aa7fb1827" />
<img width="250" alt="WhatsApp Image" src="https://github.com/user-attachments/assets/9a272bd4-ff1c-4c59-9e25-02f59045cd92" />
<img width="250" alt="WhatsApp Image" src="https://github.com/user-attachments/assets/c2a2d995-f3a4-4485-bee8-5bdc4ae23c78" />
## Video Of AnubhutiApp
https://github.com/user-attachments/assets/313b1633-570d-4d99-a273-814abf468d83
## 🙏 About

Anubhuti was made with the belief that everyone deserves a quiet moment to feel their feelings — without noise, without distraction.

Sit. Breathe. Write. Let it be.

---

*Made with 💚 using Flutter*
