# 🖥️ Serial Generator - Flutter Desktop App

**Serial Generator** is a Flutter desktop application designed specifically for **Windows**.  
It allows users to import a **PDF** or **image file**, specify the **number of receipt books**, set the **starting serial number**, and automatically generate a **final PDF file** with all pages numbered sequentially.

---

## ✨ Features

- 📄 Import **PDF files** or **image files**.
- 🔢 Set the **number of receipt books**.
- 🔖 Specify the **first serial number**, and the app auto-generates serials for all pages.
- 📥 Export the final **PDF file** with serial numbers applied.
- 🖥️ Designed exclusively for **Windows desktop** (not mobile).

---

## 🛠️ Technologies & Packages

This app is built using **Flutter** and leverages the following packages:

- [`pdf`](https://pub.dev/packages/pdf) - For generating and exporting PDF files.
- File pickers for selecting input files (like images and PDFs).

---

## 🧩 Architecture

- No formal **state management** is used.
- Simple state handling using **`ChangeNotifier`** only.
- Focused on **keeping the logic simple and lightweight**.

---

## 🗂️ Project Scope

- ✅ Desktop-only (Windows).
- ✅ No mobile or web support.
- ✅ Built for personal/business use cases like managing serialized **receipt books**.

---

## 📥 Installation & Usage

1. Clone the repository:
    ```bash
    git clone https://github.com/Gemy-Dev/SerialImageGeneratorPdf.git
    ```
2. Navigate into the project folder:
  
    ```
3. Install dependencies:
    ```bash
    flutter pub get
    ```
4. Run the app:
    ```bash
    flutter run -d windows
    ```

---

## 📄 Future Plans

- 🔄 Code refactor to improve structure and readability.
- 🖼️ Improve UI/UX.
- 📊 Add basic error handling for file imports and exports.

---

## 📝 Notes

- This app was developed for **Windows desktop** only.
- It does not use complex state management solutions—only **`ChangeNotifier`** is used for simple state updates.
- The app focuses on **functional simplicity**, allowing quick serial generation with minimal setup.

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

## 📧 Contact

For questions, contributions, or feedback, feel free to open an issue or contact me directly.

---

Made with ❤️ using Flutter.
