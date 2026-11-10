# Ruqyah — App Store Submission via Codemagic (No Mac Needed)

---

## What you need before starting
- Apple Developer account (SimpleAI LLC) — $99/yr at developer.apple.com
- GitHub account
- Codemagic account (free at codemagic.io)

---

## Step 1 — Register the App ID on Apple Developer

1. Go to [developer.apple.com](https://developer.apple.com) → Certificates, IDs & Profiles → Identifiers
2. Click **+** → App IDs → App
3. Bundle ID: **com.simpleai.ruqyah** (Explicit)
4. Enable capabilities: none needed beyond defaults
5. Click Continue → Register

---

## Step 2 — Create the app in App Store Connect

1. Go to [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
2. My Apps → **+** → New App
3. Platform: iOS | Name: **Ruqyah** | Bundle ID: com.simpleai.ruqyah
4. Fill in description, screenshots, category (**Reference**), age rating (**4+**)
5. Add a Privacy Policy URL (required — even a simple one on GitHub Pages works)

---

## Step 3 — Get your App Store Connect API Key

1. App Store Connect → Users and Access → **Integrations** tab → App Store Connect API
2. Click **+** → Name: "Codemagic", Role: **App Manager**
3. Download the **.p8 file** — save it, you can only download it once
4. Note the **Key ID** and **Issuer ID** shown on the same page

---

## Step 4 — Get your iOS Distribution Certificate key

Codemagic can create a new certificate for you automatically — you just need a private key:

**Option A — Let Codemagic create everything (easiest):**
1. In Codemagic → your app → Environment variables, add:
   - `CERTIFICATE_PRIVATE_KEY` → paste output of:
     ```
     openssl genrsa -out key.pem 2048 && cat key.pem
     ```
     Run that in any terminal (Windows: Git Bash, Linux/Mac: Terminal)
2. Codemagic will create and sign a new Distribution certificate automatically

---

## Step 5 — Push to GitHub

Unzip `ruqyah-ios.zip`, open a terminal inside the `ruqyah-ios` folder, then:

```bash
git init
git add .
git commit -m "Initial Ruqyah iOS app"
git branch -M main

# Create a new repo at github.com/new, then:
git remote add origin https://github.com/YOUR_USERNAME/ruqyah-ios.git
git push -u origin main
```

---

## Step 6 — Set up Codemagic

1. Go to [codemagic.io](https://codemagic.io) → Sign in with GitHub
2. Add your `ruqyah-ios` repository
3. Codemagic will auto-detect the `codemagic.yaml` file
4. Go to **App Settings → Environment variables**, add these (all marked **Secure**):

| Variable | Value |
|---|---|
| `APP_STORE_CONNECT_ISSUER_ID` | Issuer ID from Step 3 |
| `APP_STORE_CONNECT_KEY_IDENTIFIER` | Key ID from Step 3 |
| `APP_STORE_CONNECT_PRIVATE_KEY` | Contents of the .p8 file |
| `CERTIFICATE_PRIVATE_KEY` | Your private key from Step 4 |

---

## Step 7 — Run the build

1. In Codemagic → click **Start new build**
2. Branch: `main`, Workflow: `iOS App Store Release`
3. Build takes ~15–20 minutes
4. On success, the IPA is uploaded to **TestFlight** automatically
5. You'll get an email at asilyas98@gmail.com when done

---

## Step 8 — Release from App Store Connect

1. App Store Connect → your app → TestFlight → confirm the build passes review
2. App Store tab → Select the build → Submit for Review
3. Apple review takes 1–3 days

---

## Notes
- `NSAllowsArbitraryLoads = true` is in Info.plist for the Quran API and audio CDN — mention this in the App Review notes when submitting
- App icon is at `Ruqyah/Assets.xcassets/AppIcon.appiconset/AppIcon.png` — replace with your own 1024×1024 PNG if desired
