# Indigovioleska — custom Iosevka build

A personal Iosevka variant (`ss08` base) patched with Nerd Fonts glyphs.
The built `.ttf` files ship in this dotfiles repo under `~/Library/Fonts/Indigovioleska*.ttf`,
so a fresh machine gets working fonts without rebuilding. Rebuild only when
changing the design or bumping upstream versions.

## What's tracked in yadm

- `private-build-plans.toml` — the build plan (this is the source of truth for the design)
- `README.md` — this file
- `~/Library/Fonts/Indigovioleska*.ttf` — the 24 built + patched font files

Deliberately **not** tracked (regenerable / large): `Iosevka/` (upstream clone),
`patched/` (build output), `nerd-fonts-patcher/`, `FontPatcher.zip`.

## Versions

- **Iosevka**: `v34.1.0` (https://github.com/be5invis/Iosevka)
- **Nerd Fonts patcher**: `font-patcher` from nerd-fonts commit `dc4e3309` (2025-04-24),
  bundled here as `FontPatcher.zip` / `nerd-fonts-patcher/`

## Rebuild

```sh
cd ~/dev/custom-iosevka

# 1. Fetch the pinned Iosevka source
git clone --depth 1 --branch v34.1.0 https://github.com/be5invis/Iosevka.git

# 2. Drop in the build plan and build the plain TTFs
cp private-build-plans.toml Iosevka/private-build-plans.toml
cd Iosevka
npm ci
npm run build -- ttf::Indigovioleska      # -> dist/Indigovioleska/TTF/*.ttf
cd ..

# 3. Patch each TTF with Nerd Fonts glyphs (monospaced -> *NerdFontMono*)
#    Requires fontforge. Produces the ./patched/ set.
mkdir -p patched
for f in Iosevka/dist/Indigovioleska/TTF/*.ttf; do
  fontforge --script nerd-fonts-patcher/font-patcher --complete --mono \
    --outputdir patched "$f"
done

# 4. Install into ~/Library/Fonts (these are what yadm tracks)
cp patched/*.ttf ~/Library/Fonts/
```

After installing, refresh the font cache (`fc-cache -f` on Linux; macOS picks them
up automatically). Re-add any changed files to yadm and commit.
