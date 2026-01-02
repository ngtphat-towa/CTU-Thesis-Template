# CTU Thesis Template (Typst) | Mẫu Luận Văn ĐHCT

[![Typst](https://img.shields.io/badge/made_with-Typst-239dad.svg)](https://typst.app/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![CTU](https://img.shields.io/badge/Can_Tho-University-003399.svg)](https://www.ctu.edu.vn/)

[English](#english) | [Tiếng Việt](#tiếng-việt)

---

<a name="english"></a>
## 🇬🇧 English

### Introduction
This project provides a modern, high-performance thesis template for **Can Tho University (CTU)** students, built using [Typst](https://typst.app/). It is designed to strictly follow the CTU Thesis Guidelines (2025-2026) for the College of Information and Communication Technology.

### Features
*   **⚡ Fast Compilation**: Instant preview and compilation using Typst.
*   **📏 CTU Compliant**: Pre-configured margins, fonts (Times New Roman), spacing, and styles according to official guidelines.
*   **🌐 Dual Language**: Built-in support for both **English** and **Vietnamese** thesis writing.
*   **🛠️ Automation**: Includes scripts (`.ps1`, `.sh`) to scaffold a new thesis project in seconds.
*   **🔋 Batteries Included**: Ready-to-use structures for chapters, front matter (cover, abstract, acknowledgement), back matter (references, appendices), and figures/tables.

### Prerequisites
1.  **Typst CLI**: [Install Typst](https://github.com/typst/typst/releases) or use the [Web App](https://typst.app/).
2.  **Git**: For version control (recommended).

### Quick Start

#### 1. Generate Your Project
You don't need to clone this entire repo if you just want to start writing. You can use the generator scripts.

**On Windows (PowerShell):**
```powershell
.\Generate-CtUThesis.ps1
# Follow the interactive prompts to set up your name, ID, and thesis title.
```

**On Linux / macOS:**
```bash
chmod +x generate-ctu-thesis.sh
./generate-ctu-thesis.sh
# Follow the interactive prompts.
```

#### 2. Compile
Navigate to your newly created thesis folder (default `ctu-thesis`) and compile:

```bash
# One-time build
typst compile main.typ thesis.pdf

# Watch mode (live updates)
typst watch main.typ thesis.pdf
```

### Usage Guide

1.  **Configuration**: Open `info.typ`. This is the single source of truth for your thesis metadata (Name, Title, Advisor, etc.).
    ```typst
    // info.typ
    ...
    primary_lang: "en", // Set to "vi" for Vietnamese
    student: (
      name: "Your Name",
      ...
    )
    ...
    ```
2.  **Writing Content**:
    *   Chapters are located in `chapters/`.
    *   Add your content in `chapters/part1/`, `chapters/part2/`, etc.
    *   The `main.typ` file connects everything.
3.  **Bibliography**: Add your `.bib` entries to `backmatter/bibliography.bib` and cite them using `@key`.

### Project Structure
```
my-thesis/
├── info.typ                    # ⚙️ Configuration (Edit this first!)
├── main.typ                    # 📄 Entry point
├── template/                   # 🎨 CTU Style definitions (Do not edit)
├── frontmatter/                # 📝 Cover, Abstract, TOC
├── chapters/                   # 📚 Your thesis content
│   ├── part1/                  # Introduction
│   ├── part2/                  # Core chapters
│   └── part3/                  # Conclusion
├── backmatter/                 # 📎 References & Appendices
└── images/                     # 🖼️ Image assets
```

---

<a name="tiếng-việt"></a>
## 🇻🇳 Tiếng Việt

### Giới thiệu
Dự án này cung cấp mẫu luận văn hiện đại, hiệu năng cao cho sinh viên **Đại học Cần Thơ (ĐHCT)**, được xây dựng bằng [Typst](https://typst.app/). Mẫu này được thiết kế tuân thủ nghiêm ngặt Quy định Luận văn ĐHCT (2025-2026) của Trường Công nghệ Thông tin và Truyền thông.

### Tính năng
*   **⚡ Biên dịch Nhanh**: Xem trước và biên dịch tức thì với Typst.
*   **📏 Chuẩn ĐHCT**: Cấu hình sẵn lề, phông chữ (Times New Roman), giãn dòng và kiểu dáng theo quy định chính thức.
*   **🌐 Đa Ngôn ngữ**: Hỗ trợ sẵn cho việc viết luận văn bằng **Tiếng Anh** hoặc **Tiếng Việt**.
*   **🛠️ Tự động hóa**: Bao gồm các script (`.ps1`, `.sh`) để khởi tạo dự án luận văn mới chỉ trong vài giây.
*   **🔋 Đầy đủ Cấu trúc**: Cấu trúc sẵn sàng cho các chương, phần đầu (bìa, tóm tắt, lời cảm ơn), phần cuối (tài liệu tham khảo, phụ lục), và hình ảnh/bảng biểu.

### Yêu cầu
1.  **Typst CLI**: [Cài đặt Typst](https://github.com/typst/typst/releases) hoặc sử dụng [Web App](https://typst.app/).
2.  **Git**: Để quản lý phiên bản (khuyên dùng).

### Bắt đầu Nhanh

#### 1. Tạo Dự án
Bạn có thể sử dụng các script tạo tự động để bắt đầu.

**Trên Windows (PowerShell):**
```powershell
.\Generate-CtUThesis.ps1
# Làm theo hướng dẫn trên màn hình để nhập tên, MSSV và tên đề tài.
```

**Trên Linux / macOS:**
```bash
chmod +x generate-ctu-thesis.sh
./generate-ctu-thesis.sh
# Làm theo hướng dẫn trên màn hình.
```

#### 2. Biên dịch
Di chuyển vào thư mục luận văn vừa tạo (mặc định là `ctu-thesis`) và biên dịch:

```bash
# Biên dịch một lần
typst compile main.typ luan-van.pdf

# Chế độ theo dõi (cập nhật trực tiếp khi lưu file)
typst watch main.typ luan-van.pdf
```

### Hướng dẫn Sử dụng

1.  **Cấu hình**: Mở file `info.typ`. Đây là nơi chứa toàn bộ thông tin về luận văn của bạn (Tên, Đề tài, GVHD, v.v.).
    ```typst
    // info.typ
    ...
    primary_lang: "vi", // Đặt là "vi" cho Tiếng Việt
    student: (
      name: "Nguyễn Văn A",
      ...
    )
    ...
    ```
2.  **Viết Nội dung**:
    *   Các chương nằm trong thư mục `chapters/`.
    *   Thêm nội dung vào `chapters/part1/`, `chapters/part2/`, v.v.
    *   File `main.typ` kết nối tất cả các phần lại với nhau.
3.  **Tài liệu tham khảo**: Thêm các mục `.bib` vào `backmatter/bibliography.bib` và trích dẫn bằng cú pháp `@key`.

### Cấu trúc Dự án
```
my-thesis/
├── info.typ                    # ⚙️ Cấu hình (Sửa file này đầu tiên!)
├── main.typ                    # 📄 File chính
├── template/                   # 🎨 Định nghĩa kiểu dáng CTU (Không nên sửa)
├── frontmatter/                # 📝 Bìa, Tóm tắt, Mục lục
├── chapters/                   # 📚 Nội dung luận văn
│   ├── part1/                  # Giới thiệu
│   ├── part2/                  # Nội dung chính
│   └── part3/                  # Kết luận
├── backmatter/                 # 📎 Tài liệu tham khảo & Phụ lục
└── images/                     # 🖼️ Thư mục hình ảnh
```

---

## 🤝 Community & Contributing

We welcome contributions from the community! Whether it's reporting a bug, suggesting a feature, or submitting a pull request, your input is valued.

*   **Contributing Guide**: Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests.
*   **Code of Conduct**: We pledge to foster an open and welcoming environment. Please review [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).
*   **Bug Reports**: Use the [Bug Report Template](.github/ISSUE_TEMPLATE/bug_report.md).
*   **Feature Requests**: Use the [Feature Request Template](.github/ISSUE_TEMPLATE/feature_request.md).

## 📜 Citation

If you use this template for your academic work, please cite it using the metadata in [CITATION.cff](CITATION.cff).

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

<!-- 
Keywords: Typst, CTU, Can Tho University, Thesis Template, Đại học Cần Thơ, Luận văn tốt nghiệp, 
Mẫu luận văn Typst, Academic Writing, Research Paper, CTU ICT, College of ICT, 
Vietnam University, LaTeX alternative, PDF generation, Graduation Report.
-->
