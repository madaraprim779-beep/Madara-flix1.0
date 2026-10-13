
name: MADARA FLIX 1.0 - Build APK

on:
  workflow_dispatch:
  push:
    branches:
      - main

permissions:
  contents: read

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Recuperer le projet
        uses: actions/checkout@v4

      - name: Installer Java
        uses: actions/setup-java@v4
        with:
          distribution: temurin
          java-version: '17'

      - name: Installer Flutter
        uses: subosito/flutter-action@v2
        with:
          channel: stable
          cache: true

      - name: Generer le projet Flutter
        run: |
          flutter create --project-name madara_flix --platforms=android,web .
          
      - name: Construire APK Android
        run: flutter build apk --debug

      - name: Publier APK
        uses: actions/upload-artifact@v4
        with:
          name: MADARA-FLIX-APK
          path: build/app/outputs/flutter-apk/app-debug.apk
