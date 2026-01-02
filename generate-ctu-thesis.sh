#!/bin/bash

# ============================================================================
# CTU THESIS PROJECT GENERATOR - BASH EDITION
# Can Tho University - College of Information and Communication Technology
# ============================================================================

set -e  # Exit on error

# ============================================================================
# DEFAULT PARAMETERS
# ============================================================================
PROJECT_NAME="ctu-thesis"
LANGUAGE="en"
STUDENT_NAME=""
STUDENT_ID=""
THESIS_TITLE=""
INTERACTIVE=true

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

write_section_header() {
    echo -e "\n\033[36m============================================================\033[0m"
    echo -e "\033[33m  $1\033[0m"
    echo -e "\033[36m============================================================\033[0m\n"
}

write_success() {
    echo -e "\033[32m✅ $1\033[0m"
}

write_info() {
    echo -e "\033[34m📝 $1\033[0m"
}

new_file_with_content() {
    local filepath="$1"
    local content="$2"
    
    local dirpath=$(dirname "$filepath")
    if [ -n "$dirpath" ] && [ ! -d "$dirpath" ]; then
        mkdir -p "$dirpath"
    fi
    
    echo "$content" > "$filepath"
    write_success "Created: $(basename "$filepath")"
}

# ============================================================================
# PARSE ARGUMENTS
# ============================================================================

show_help() {
    cat << 'EOF'
CTU Thesis Project Generator

Usage: $0 [OPTIONS]

Options:
    -p, --project NAME      Project folder name (default: ctu-thesis)
    -l, --language LANG     Primary language: en/vi (default: en)
    -n, --name NAME         Student's full name
    -i, --id ID             Student ID (e.g., B1234567)
    -t, --title TITLE       Thesis title
    --non-interactive       Disable interactive prompts
    -h, --help              Show this help message

Examples:
    $0
    $0 -p my-thesis -l vi
    $0 -p ecommerce-thesis -n "Nguyen Van A" -i B2012345

EOF
    exit 0
}

while [[ $# -gt 0 ]]; do
    case $1 in
        -p|--project) PROJECT_NAME="$2"; shift 2 ;;
        -l|--language) LANGUAGE="$2"; shift 2 ;;
        -n|--name) STUDENT_NAME="$2"; shift 2 ;;
        -i|--id) STUDENT_ID="$2"; shift 2 ;;
        -t|--title) THESIS_TITLE="$2"; shift 2 ;;
        --non-interactive) INTERACTIVE=false; shift ;;
        -h|--help) show_help ;;
        *) echo "Unknown option: $1"; show_help ;;
    esac
done

# ============================================================================
# BANNER
# ============================================================================

clear
cat << "EOF"

  ╔═══════════════════════════════════════════════════════════╗
  ║                                                           ║
  ║     🎓  CTU THESIS PROJECT GENERATOR  🎓                  ║
  ║                                                           ║
  ║     Can Tho University - College of ICT                   ║
  ║     Typst Template Generator                              ║
  ║                                                           ║
  ╚═══════════════════════════════════════════════════════════╝

EOF

# ============================================================================
# INTERACTIVE INPUT
# ============================================================================

if [ "$INTERACTIVE" = true ]; then
    write_info "Let's set up your thesis project!\n"
    
    if [ -z "$PROJECT_NAME" ] || [ "$PROJECT_NAME" = "ctu-thesis" ]; then
        read -p "Project folder name (default: ctu-thesis): " input
        [ -n "$input" ] && PROJECT_NAME="$input"
    fi
    
    if [ -z "$LANGUAGE" ]; then
        read -p "Primary language (en/vi, default: en): " input
        if [ "$input" = "en" ] || [ "$input" = "vi" ]; then
            LANGUAGE="$input"
        fi
    fi
    
    if [ -z "$STUDENT_NAME" ]; then
        read -p "Your full name (optional, can edit later in info.typ): " STUDENT_NAME
    fi
    
    if [ -z "$STUDENT_ID" ]; then
        read -p "Student ID (optional, e.g., B1234567): " STUDENT_ID
    fi
    
    if [ -z "$THESIS_TITLE" ]; then
        read -p "Thesis title (optional, can edit later): " THESIS_TITLE
    fi
fi

# Set defaults if still empty
STUDENT_NAME="${STUDENT_NAME:-Your Name}"
STUDENT_ID="${STUDENT_ID:-B1234567}"
THESIS_TITLE="${THESIS_TITLE:-Your Thesis Title Here}"

# ============================================================================
# CREATE PROJECT STRUCTURE
# ============================================================================

write_section_header "Creating Project Structure"

# Create base directory
if [ -d "$PROJECT_NAME" ]; then
    read -p "Project '$PROJECT_NAME' exists. Overwrite? (y/N): " overwrite
    if [ "$overwrite" != "y" ]; then
        echo "Cancelled by user"
        exit 0
    fi
    rm -rf "$PROJECT_NAME"
fi

mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

write_info "Creating directory structure..."

clear

write_section_header "Creating Project Structure"

cd $PROJECT_NAME

write_info "Creating directory structure..."

# Create all directories
mkdir -p "template"
mkdir -p "frontmatter"
mkdir -p "backmatter"
mkdir -p "chapters/part1"
mkdir -p "chapters/part2/chapter1"
mkdir -p "chapters/part2/chapter2"
mkdir -p "chapters/part2/chapter3"
mkdir -p "chapters/part3"
mkdir -p "images/chapter1"
mkdir -p "images/chapter2"
mkdir -p "images/chapter3"
mkdir -p "images/logo"

write_success "Directory structure created"

write_section_header "Creating Configuration Files"

new_file_with_content "info.typ" "
// ============================================================================
// CTU THESIS INFORMATION CONFIGURATION
// Can Tho University - College of Information and Communication Technology
// ============================================================================

#let info = (
  en: (
    student: (
      name: "$STUDENT_NAME",
      id: "$STUDENT_ID",
      class: "Your Class",
      major: "INFORMATION TECHNOLOGY",
      program: "High-Quality Program",
    ),
    advisor: (
      name: "Dr. Advisor Name",
      title: "Dr.", // Academic title
    ),
    thesis: (
      title: "$THESIS_TITLE",
      short_title: "SHORT TITLE FOR HEADERS", // Max 50 characters
      date: "December 2025",
      location: "Can Tho",
      degree: "BACHELOR OF ENGINEERING",
    ),
    keywords: (
      "keyword 1", 
      "keyword 2", 
      "keyword 3",
      "keyword 4",
      "keyword 5"
    ),
    committee: (
      chairman: "Dr. Chairman Name",
      reviewer: "Dr. Reviewer Name",
      advisor: "Dr. Advisor Name",
    ),
    abbreviations: (
      ("API", "Application Programming Interface"),
      ("CTU", "Can Tho University"),
      ("ICT", "Information and Communication Technology"),
      ("UI/UX", "User Interface/User Experience"),
      ("HTTP", "Hypertext Transfer Protocol"),
    ),
  ),
  vi: (
    student: (
      name: "$STUDENT_NAME",
      id: "$STUDENT_ID",
      class: "Lớp Của Bạn",
      major: "Công nghệ Thông tin",
      program: "Chất lượng cao",
    ),
    advisor: (
      name: "TS. Tên GVHD",
      title: "TS.",
    ),
    thesis: (
      title: "$THESIS_TITLE",
      short_title: "TIÊU ĐỀ NGẮN", // Tối đa 50 ký tự
      date: "Tháng 12/2025",
      location: "Cần Thơ",
      degree: "KỸ SƯ",
    ),
    keywords: (
      "từ khóa 1", 
      "từ khóa 2", 
      "từ khóa 3",
      "từ khóa 4",
      "từ khóa 5"
    ),
    committee: (
      chairman: "TS. Tên Chủ Tịch",
      reviewer: "TS. Tên Phản Biện",
      advisor: "TS. Tên GVHD",
    ),
    abbreviations: (
      ("API", "Giao diện lập trình ứng dụng"),
      ("CTU", "Đại học Cần Thơ"),
      ("CNTT-TT", "Công nghệ Thông tin và Truyền thông"),
      ("UI/UX", "Giao diện/Trải nghiệm người dùng"),
      ("HTTP", "Giao thức truyền tải siêu văn bản"),
    ),
  ),
)

// ============================================================================
// GLOBAL SETTINGS (CTU STANDARD)
// ============================================================================
#let settings = (
  primary_lang: "$LANGUAGE",
  
  // CTU Official Colors
  border_color: rgb(0, 51, 153), // CTU Blue (#003399)
  accent_color: rgb(0, 83, 159), // CTU Accent (#00539F)
  
  // CTU Format Requirements (2025-2026)
  format: (
    font: "Times New Roman",
    font_size: 13pt,
    line_spacing: 1.2,      // Main text: 1.2 spacing
    margins: (
      left: 4cm,            // CTU Standard: 4cm left
      right: 2.5cm,         // CTU Standard: 2.5cm other sides
      top: 2.5cm,
      bottom: 2.5cm,
    ),
    paragraph_indent: 1cm,  // First line indent
    abstract_words: (200, 350), // Min-max words
  ),
)
"

new_file_with_content "main.typ" "
// ============================================================================
// CTU GRADUATION THESIS - MAIN FILE
// Can Tho University Format (2025-2026)
// ============================================================================

// 1. CONFIGURATION & IMPORTS
#import "info.typ": *
#import "template/ctu-styles.typ": ctu-styles
#import "template/i18n.typ": term

// 2. GLOBAL SETTINGS
#let lang = settings.primary_lang

// 3. DOCUMENT SETUP (CTU Format)
#show: doc => ctu-styles(doc, lang: lang)

// Document Metadata
#set document(
  title: info.at(lang).thesis.title,
  author: info.at(lang).student.name,
  keywords: info.at(lang).keywords,
)

// ============================================================================
// 4. FRONT MATTER (Roman numerals i, ii, iii...)
// ============================================================================
#set page(numbering: "i")
#counter(page).update(1)

// Cover Pages
#import "frontmatter/cover.typ": cover-page
#import "frontmatter/inner-cover.typ": inner-cover-page

#cover-page(lang: lang)
#inner-cover-page(lang: lang)

// Evaluation & Acknowledgements
#include "frontmatter/evaluation.typ"
#include "frontmatter/acknowledgements.typ"

// Lists (TOC, LOF, LOT)
#include "frontmatter/table-of-contents.typ"
#pagebreak()

#include "frontmatter/list-of-figures.typ"
#pagebreak()

#include "frontmatter/list-of-tables.typ"
#pagebreak()

// Abbreviations & Abstract
#include "frontmatter/abbreviations.typ"
#include "frontmatter/abstract.typ"

// ============================================================================
// 5. MAIN CONTENT (Arabic numerals 1, 2, 3...)
// ============================================================================
#set page(numbering: "1")
#counter(page).update(1)
#set heading(numbering: "1.1.1.1") // Enable automatic numbering

// Helper for Part Headings (Visual separator, appears in outline)
#let part-heading(body) = {
  pagebreak()
  v(2cm)
  heading(level: 1, numbering: none, outlined: true)[#body]
}

// PART 1: INTRODUCTION
#part-heading[#term(lang, "part") 1: INTRODUCTION]
#counter(heading).update(1)
#include "chapters/part1-introduction.typ"

// PART 2: THESIS CONTENT
#part-heading[#term(lang, "part") 2: THESIS CONTENT]
#include "chapters/part2-content.typ"

// PART 3: CONCLUSION
#part-heading[#term(lang, "part") 3: CONCLUSION AND FUTURE WORK]
#counter(heading).step()
#include "chapters/part3-conclusion.typ"

// ============================================================================
// 6. BACK MATTER
// ============================================================================

// REFERENCES (IEEE Style - CTU Standard)
#pagebreak()
#bibliography("backmatter/bibliography.bib", title: term(lang, "ref"), style: "ieee")

// APPENDICES
#pagebreak()
#set page(numbering: none)
#counter(heading).update(0)
#set heading(numbering: "A.1")
#include "backmatter/appendices.typ"
"

write_section_header "Creating Template Files"

new_file_with_content "template/i18n.typ" "
// ============================================================================
// INTERNATIONALIZATION DICTIONARY (CTU STANDARD)
// Contains official CTU terminology in English and Vietnamese
// ============================================================================

#let dict = (
  en: (
    // Organization (CTU Official)
    ministry: "MINISTRY OF EDUCATION AND TRAINING",
    university: "CAN THO UNIVERSITY",
    college: "COLLEGE OF INFORMATION AND COMMUNICATION TECHNOLOGY",
    department: "DEPARTMENT OF SOFTWARE ENGINEERING",
    
    // Document Type
    thesis_type: "GRADUATION THESIS",
    in_major: "IN",
    
    // Labels
    student_label: "Student:",
    student_id_label: "Student ID:",
    class_label: "Class:",
    advisor_label: "Advisor:",
    keywords_label: "Keywords:",
    
    // Headings
    figure: "Figure",
    table: "Table",
    toc: "TABLE OF CONTENTS",
    lof: "LIST OF FIGURES",
    lot: "LIST OF TABLES",
    ref: "REFERENCES",
    appendix: "APPENDICES",
    part: "PART",
    chapter: "CHAPTER",
    
    // Front Matter
    abbreviations_title: "LIST OF ABBREVIATIONS",
    abbreviations_term: "Abbreviation",
    abbreviations_desc: "Description",
    abstract_title: "ABSTRACT",
    acknowledgments_title: "ACKNOWLEDGEMENTS",
    evaluation_title: "EVALUATION OF ADVISOR",
  ),
  vi: (
    // Organization (CTU Official Vietnamese)
    ministry: "BỘ GIÁO DỤC VÀ ĐÀO TẠO",
    university: "ĐẠI HỌC CẦN THƠ",
    college: "TRƯỜNG CÔNG NGHỆ THÔNG TIN VÀ TRUYỀN THÔNG",
    department: "KHOA CÔNG NGHỆ PHẦN MỀM",
    
    // Document Type
    thesis_type: "LUẬN VĂN TỐT NGHIỆP",
    in_major: "NGÀNH",
    
    // Labels
    student_label: "Sinh viên thực hiện:",
    student_id_label: "MSSV:",
    class_label: "Lớp:",
    advisor_label: "Cán bộ hướng dẫn:",
    keywords_label: "Từ khóa:",
    
    // Headings
    figure: "Hình",
    table: "Bảng",
    toc: "MỤC LỤC",
    lof: "DANH MỤC HÌNH",
    lot: "DANH MỤC BẢNG",
    ref: "TÀI LIỆU THAM KHẢO",
    appendix: "PHỤ LỤC",
    part: "PHẦN",
    chapter: "CHƯƠNG",
    
    // Front Matter
    abbreviations_title: "DANH MỤC TỪ VIẾT TẮT",
    abbreviations_term: "Từ viết tắt",
    abbreviations_desc: "Diễn giải",
    abstract_title: "TÓM TẮT",
    acknowledgments_title: "LỜI CẢM ƠN",
    evaluation_title: "NHẬN XÉT CỦA CÁN BỘ HƯỚNG DẪN",
  ),
)

// Helper function to retrieve a term
#let term(lang, key) = {
  let lang-dict = dict.at(lang, default: dict.en)
  lang-dict.at(key, default: key)
}
"

write_info "Creating CTU style template..."

new_file_with_content "template/ctu-styles.typ" "
// ============================================================================
// CTU THESIS STYLES
// Based on CTU Format Guidelines (2025-2026)
// Fonts: Times New Roman 13pt
// Margins: Left 4cm, Others 2.5cm
// Line Spacing: 1.2 for main text
// ============================================================================

#import "i18n.typ": term
#import "../info.typ": info, settings

#let ctu-styles(
  doc,
  lang: "en",
) = {
  
  // Localized header content
  let header-title = info.at(lang).thesis.short_title
  
  // Page geometry (CTU Standard)
  set page(
    paper: "a4",
    margin: settings.format.margins,
    
    // Header: Title + Line (only for main content)
    header: context {
      if page.numbering == "1" {
        set text(size: 9pt, style: "italic")
        grid(
          columns: (1fr),
          align: (left+bottom),
          block(width: 100%, clip: true, height: 1.2em)[#upper(header-title)],
        )
        v(-5pt) 
        line(length: 100%, stroke: 0.5pt)
      }
    },

    // Footer: Line + Page Number
    footer: context {
      if page.numbering != none {
        set align(center)
        line(length: 100%, stroke: 0.5pt)
        v(0.1cm)
        text(size: 11pt)[#counter(page).display(page.numbering)]
      }
    }
  )
  
  // Main text settings (CTU Standard: Times New Roman, 13pt)
  set text(
    font: settings.format.font,
    size: settings.format.font_size,
    lang: lang,
  )
  
  // Paragraph settings (CTU Standard: 1.2 spacing, 1cm indent)
  set par(
    justify: true,
    leading: 0.25cm,  // 1.2 line spacing ≈ 0.25cm
    first-line-indent: settings.format.paragraph_indent,
  )

  // Headings (CTU Format)
  show heading.where(level: 1): it => {
    set align(center)
    set text(size: 14pt, weight: "bold")
    {
      show text: upper
      it
    }
    v(12pt)
  }
  
  show heading.where(level: 2): it => {
    set text(size: 13pt, weight: "bold")
    {
      show text: upper
      it
    }
    v(0.6cm)
  }
  
  show heading.where(level: 3): it => {
    set text(size: 13pt, weight: "bold")
    v(0.3cm)
    it
    v(0.3cm)
  }
  
  // Figures (CTU Format: Single line spacing, centered)
  show figure.where(kind: image): it => {
    set align(center)
    it.body
    v(0.3cm)
    set text(size: 12pt)
    set par(leading: 0.15cm) // Single spacing for captions
    [#term(lang, "figure") #it.counter.display(it.numbering). #it.caption]
    v(0.6cm)
  }
  
  // Tables (CTU Format: Single line spacing, caption above)
  show figure.where(kind: table): it => {
    set align(center)
    v(0.6cm)
    set text(size: 12pt)
    set par(leading: 0.15cm) // Single spacing for captions
    [#term(lang, "table") #it.counter.display(it.numbering). #it.caption]
    v(0.3cm)
    it.body
    v(0.6cm)
  }
  
  // Code blocks
  show raw.where(block: true): it => {
    set text(size: 10pt, font: "Courier New")
    set par(leading: 0.15cm) // Single spacing for code
    block(
      fill: rgb("#f5f5f5"),
      inset: 0.3cm,
      radius: 0.1cm,
      width: 100%,
      it
    )
  }
  
  doc
}
"

write_section_header "Creating Front Matter"

new_file_with_content "frontmatter/cover.typ" "
// CTU Main Cover Page
#import "../info.typ": *
#import "../template/i18n.typ": term

#let cover-page(lang: "en") = {
  let data = info.at(lang)
  
  page(
    margin: (left: 3cm, right: 3cm, top: 2cm, bottom: 2cm),
    numbering: none,
    header: none,
    footer: none,
  )[
    #rect(
      width: 100%,
      height: 100%,
      stroke: settings.border_color + 2pt,
      inset: 1.5cm,
    )[
      #set align(center)
      
      // University Header
      #block(width: 100%)[
        #set par(leading: 0.3cm, justify: false)
        #set text(size: 13pt, weight: "bold", tracking: 0.2pt)
        
        #upper(term(lang, "ministry")) \ #upper(term(lang, "university")) \ #upper(term(lang, "college")) \ #upper(term(lang, "department"))
      ]

      #v(1fr)

      // Logo Placeholder
      #box(width: 3cm, height: 3cm, stroke: 1pt, radius: 50%)[
        #align(center+horizon)[LOGO]
      ]

      #v(1fr)

      // Thesis Type
      #text(size: 14pt, weight: "bold")[
        #upper(term(lang, "thesis_type")) \ #upper(data.thesis.degree) #upper(term(lang, "in_major")) \ #upper(data.student.major) \ #v(0.3cm)
        (#upper(data.student.program))
      ]

      #v(1fr)

      // Title
      #block(width: 90%)[
        #set par(leading: 0.2cm)
        #text(size: 18pt, weight: "bold")[
          #upper(data.thesis.title)
        ]
      ]

       #v(2fr)

      // Student Info
      #align(center)[
        #grid(
          columns: (auto, auto),
          column-gutter: 1cm,
          row-gutter: 0.4cm,
          align: (right, left),

          text(size: 13pt, weight: "bold")[#term(lang, "student_label")], text(size: 13pt)[#data.student.name],
          text(size: 13pt, weight: "bold")[#term(lang, "student_id_label")], text(size: 13pt)[#data.student.id],
          text(size: 13pt, weight: "bold")[#term(lang, "class_label")], text(size: 13pt)[#data.student.class],
          text(size: 13pt, weight: "bold")[#term(lang, "advisor_label")], text(size: 13pt)[#data.advisor.name],
        )
      ]

      #v(1fr)

      // Date
      #text(size: 13pt)[#data.thesis.location, #data.thesis.date]
    ]
  ]
}
"

new_file_with_content "frontmatter/acknowledgements.typ" "
#import "../info.typ": *
#import "../template/i18n.typ": term

#let lang = settings.primary_lang

#heading(level: 1, numbering: none, outlined: true)[#term(lang, "acknowledgments_title")]
#v(1cm)
#set align(left)
#set par(first-line-indent: 1cm)

I wish to express my deep gratitude to my advisor for their guidance throughout this thesis. I would also like to thank the lecturers at Can Tho University for their invaluable knowledge.

I am grateful to my family for their love and support, and to my friends for their encouragement.

#v(1cm)
#set align(right)
Sincerely,

Can Tho, [Date]

#v(1cm)
[Your Name]
#pagebreak()
"

new_file_with_content "frontmatter/abstract.typ" "
#import "../info.typ": *
#import "../template/i18n.typ": term

#let lang = settings.primary_lang
#let data = info.at(lang)

#heading(level: 1, numbering: none, outlined: true)[#term(lang, "abstract_title")]
#v(1cm)
#set align(left)
#set par(first-line-indent: 1cm, justify: true)

// CTU Requirement: 200-350 words
// Include: Problem, Methodology, Results, Conclusions

Write your abstract here (200-350 words as per CTU guidelines).

Structure:
1. Introduction to research topic and objectives
2. Main methodology and approach
3. Summary of results and findings  
4. Main conclusions and recommendations

#v(1cm)
#set text(style: "normal")
#par(first-line-indent: 0cm)[
  *#term(lang, "keywords_label")* #data.keywords.join(", ")
]

#pagebreak()
"

write_info "Creating remaining essential files..."

new_file_with_content "frontmatter/evaluation.typ" "
#import "../info.typ": *
#import "../template/i18n.typ": term

#let lang = settings.primary_lang
#let data = info.at(lang)

#set page(numbering: "i")
#heading(level: 1, numbering: none, outlined: true)[#term(lang, "evaluation_title")]
#v(1cm)
#set align(left)
#for _ in range(20) {
  line(length: 100%, stroke: 0.5pt + gray)
  v(0.8cm)
}
#v(2cm)
#set align(right)
#text(size: 13pt)[
  #term(lang, "advisor_label") \ #v(2cm)
  #line(length: 6cm) \ #data.advisor.name
]
#pagebreak()
"

new_file_with_content "frontmatter/table-of-contents.typ" "
#import "../template/i18n.typ": term

#heading(level: 1, numbering: none, outlined: true)[TABLE OF CONTENTS]
#v(1cm)

#show outline.entry.where(level: 1): it => {
  let el = it.element
  
  if el.numbering == none {
    v(12pt, weak: true)
    strong(upper(it))
  } else {
    v(12pt, weak: true)
    set text(weight: "bold")
    
    let prefix = if el.numbering == "A.1" { "APPENDIX " } else { "CHAPTER " }
    let num = numbering(el.numbering, ..counter(heading).at(el.location()))
    let page-num = counter(page).at(el.location()).first()
    
    link(el.location())[
      #upper[#prefix #num. #el.body]
      #box(width: 1fr, repeat[.])
      #page-num
    ]
  }
}

#outline(title: none, indent: auto, depth: 3)
"

new_file_with_content "frontmatter/list-of-figures.typ" "
#heading(level: 1, numbering: none, outlined: true)[LIST OF FIGURES]
#v(1cm)
#outline(title: none, target: figure.where(kind: image))
"

new_file_with_content "frontmatter/list-of-tables.typ" "
#heading(level: 1, numbering: none, outlined: true)[LIST OF TABLES]
#v(1cm)
#outline(title: none, target: figure.where(kind: table))
"

new_file_with_content "frontmatter/abbreviations.typ" "
#import "../info.typ": *
#import "../template/i18n.typ": term

#let lang = settings.primary_lang
#let data = info.at(lang)

#heading(level: 1, numbering: none, outlined: true)[#term(lang, "abbreviations_title")]
#v(1cm)
#set align(left)
#set par(first-line-indent: 0cm)

#table(
  columns: (auto, 1fr),
  stroke: none,
  align: (left, left),
  inset: (x: 8pt, y: 12pt),
  [*#term(lang, "abbreviations_term")*], [*#term(lang, "abbreviations_desc")*],
  ..data.abbreviations.flatten()
)
#pagebreak()
"

new_file_with_content "frontmatter/inner-cover.typ" "
#import "../info.typ": *
#import "../template/i18n.typ": term

#let inner-cover-page(lang: "en") = {
  let data = info.at(lang)
  
  page(
    margin: (left: 3cm, right: 3cm, top: 2cm, bottom: 2cm),
    numbering: none,
    header: none,
    footer: none,
  )[
    #rect(
      width: 100%,
      height: 100%,
      stroke: settings.border_color + 3pt,
      inset: 1cm,
    )[
      #set align(center)
      
      #block(width: 100%)[
        #set par(leading: 0.3cm, justify: false)
        #set text(size: 13pt, weight: "bold")
        
        #upper(term(lang, "ministry")) \ #upper(term(lang, "university")) \ #upper(term(lang, "college")) \ #upper(term(lang, "department"))
      ]

      #v(1fr)

      #box(width: 3.5cm, height: 3.5cm, stroke: 1pt, radius: 50%)[#align(center+horizon)[LOGO]]

      #v(1fr)

      #text(size: 14pt, weight: "bold")[
        #upper(term(lang, "thesis_type")) \ #upper(data.thesis.degree) #upper(term(lang, "in_major")) \ #upper(data.student.major) \ #v(0.3cm)
        (#upper(data.student.program))
      ]

      #v(1fr)

      #block(width: 90%)[
        #set par(leading: 0.4cm)
        #text(size: 16pt, weight: "bold")[
          #upper(data.thesis.title)
        ]
      ]

      #v(2fr)

      #align(center)[
        #grid(
          columns: (auto, auto),
          column-gutter: 1cm,
          row-gutter: 0.5cm,
          align: (right, left),

          text(size: 13pt, weight: "bold")[#term(lang, "student_label")], text(size: 13pt)[#data.student.name],
          text(size: 13pt, weight: "bold")[#term(lang, "student_id_label")], text(size: 13pt)[#data.student.id],
          text(size: 13pt, weight: "bold")[#term(lang, "class_label")], text(size: 13pt)[#data.student.class],
          text(size: 13pt, weight: "bold")[#term(lang, "advisor_label")], text(size: 13pt)[#data.advisor.name],
        )
      ]

      #v(1fr)

      #text(size: 13pt)[#data.thesis.location, 01/2026]
      #v(0.5cm)
    ]
  ]
}
"

write_section_header "Creating Chapter Structure"

new_file_with_content "chapters/part1-introduction.typ" "
#include "part1/01-context.typ"
#include "part1/02-related-work.typ"
#include "part1/03-objectives.typ"
#include "part1/04-research-content.typ"
#include "part1/05-thesis-outline.typ"
"

new_file_with_content "chapters/part1/01-context.typ" "
== Context and Problem Statement

In recent years, the rapid growth of e-commerce has transformed the retail industry. Traditional brick-and-mortar stores are increasingly moving online to reach a broader customer base. However, developing a robust e-commerce platform presents several challenges including inventory management, payment processing, and user experience optimization.

The main problem addressed in this thesis is the lack of integrated solutions that combine modern web technologies with efficient backend systems. Many existing platforms struggle with scalability, performance, and maintainability issues as business requirements evolve.

This research focuses on designing and implementing a comprehensive e-commerce system using modern technologies such as ASP.NET Core, Vue.js, and PostgreSQL. The system aims to demonstrate best practices in software architecture, including microservices, API gateway patterns, and responsive user interfaces.

According to recent studies @example2023, the global e-commerce market is expected to reach \$6.3 trillion by 2024, highlighting the importance of robust online retail solutions.
"

new_file_with_content "chapters/part1/02-related-work.typ" "
== Related Work

Several e-commerce platforms have been developed in both academic and commercial contexts. This section reviews existing solutions and identifies gaps that this thesis addresses.

=== Commercial Platforms

Popular platforms like Shopify, WooCommerce, and Magento provide comprehensive e-commerce solutions. However, they often come with limitations:

- *Shopify*: While user-friendly, it has limited customization options and vendor lock-in concerns
- *WooCommerce*: Highly customizable but can suffer from performance issues at scale
- *Magento*: Enterprise-grade but requires significant infrastructure and expertise

=== Academic Research

Recent academic work has explored various aspects of e-commerce systems:

1. Performance optimization techniques @textbook2024
2. User experience design patterns
3. Security and payment processing methodologies
4. Inventory management algorithms

=== Research Gap

Despite these contributions, there remains a need for open-source, educational e-commerce platforms that demonstrate modern software engineering practices while maintaining production-ready quality. This thesis fills this gap by providing a comprehensive reference implementation.
"

new_file_with_content "chapters/part1/03-objectives.typ" "
== Objectives and Scope

=== Primary Objectives

The primary objectives of this thesis are:

1. *Design* a scalable e-commerce system architecture using microservices patterns
2. *Implement* core functionalities including product catalog, shopping cart, and order management
3. *Develop* modern user interfaces for both customers and administrators
4. *Integrate* machine learning capabilities for product recommendations
5. *Evaluate* system performance and usability through comprehensive testing

=== Scope

The scope of this project includes:

==== In Scope
- Product catalog management
- User authentication and authorization
- Shopping cart functionality
- Order processing and tracking
- Admin dashboard
- Image-based product search using ML
- RESTful API design

==== Out of Scope
- Multi-vendor marketplace features
- Advanced analytics and reporting
- Mobile native applications
- International shipping complexities
- Payment gateway integration (simulated only)

=== Expected Outcomes

Upon completion, this thesis will deliver:

- A fully functional e-commerce platform
- Comprehensive technical documentation
- Performance evaluation results
- Best practices guide for similar projects
"

new_file_with_content "chapters/part1/04-research-content.typ" "
== Research Content

=== Research Methodology

This thesis employs a combination of research methods:

==== 1. Literature Review
Comprehensive analysis of existing e-commerce platforms, software architecture patterns, and modern web development technologies.

==== 2. Design Science Research
Following the design science methodology, this research involves:
- Problem identification
- Solution design
- Implementation
- Evaluation
- Communication of results

==== 3. Experimental Evaluation
Performance testing and usability studies to validate the proposed solution.

=== Technical Approach

The technical approach consists of several key components:

*Backend Architecture*:
- ASP.NET Core 8.0 for REST APIs
- Entity Framework Core for data access
- PostgreSQL with pgvector for database
- FastAPI for machine learning services

*Frontend Architecture*:
- Vue.js 3 with Composition API
- PrimeVue component library
- Pinia for state management
- Vite for build tooling

*Infrastructure*:
- Docker for containerization
- YARP reverse proxy as API gateway
- Redis for caching (optional)
- Git for version control

=== Development Phases

The development is structured in phases:

1. Requirements analysis and system design
2. Backend API development
3. Frontend implementation
4. Integration and testing
5. Deployment and documentation
"

new_file_with_content "chapters/part1/05-thesis-outline.typ" "
== Thesis Outline

This thesis is organized into three main parts:

=== Part 1: Introduction

Provides the foundation and context for the research:
- Problem statement and motivation
- Literature review and related work
- Research objectives and scope
- Methodology and approach
- Thesis structure overview

=== Part 2: Thesis Content

Contains the core technical contributions across three chapters:

*Chapter 1: Background and Related Work*
- Theoretical foundations
- Technology stack overview
- Architecture patterns
- Literature review details

*Chapter 2: Design and Implementation*
- System architecture design
- Database schema design
- API design and implementation
- Frontend development
- Integration strategies

*Chapter 3: Testing and Evaluation*
- Testing methodology
- Unit and integration tests
- Performance benchmarks
- Usability evaluation
- Results analysis

=== Part 3: Conclusion and Future Work

Summarizes findings and discusses future directions:
- Summary of achievements
- Contributions to the field
- Limitations and challenges
- Recommendations for future work
- Final remarks
"

new_file_with_content "chapters/part2-content.typ" "
#include "part2/chapter1-background.typ"
#include "part2/chapter2-design.typ"
#include "part2/chapter3-testing.typ"
"

new_file_with_content "chapters/part2/chapter1-background.typ" "
= CHAPTER 1: BACKGROUND AND RELATED WORK <chap1>

#include "chapter1/01-background-intro.typ"
#include "chapter1/02-technologies.typ"
#include "chapter1/03-architecture-patterns.typ"
"

new_file_with_content "chapters/part2/chapter1/01-background-intro.typ" "
== Introduction to E-Commerce Systems

E-commerce, or electronic commerce, refers to the buying and selling of goods and services over the internet. The evolution of e-commerce has dramatically changed consumer behavior and business operations globally.

=== Historical Context

The first e-commerce transaction occurred in 1994 when a CD was sold through NetMarket. Since then, the industry has experienced exponential growth.

=== Key Components

A modern e-commerce system typically consists of:

1. *Product Catalog*: Database of available products with descriptions, prices, and images
2. *Shopping Cart*: Temporary storage for items before purchase
3. *Payment Processing*: Secure handling of financial transactions
4. *Order Management*: Tracking and fulfillment of customer orders
5. *User Management*: Authentication, authorization, and profile management

These components work together to provide a complete e-commerce solution.
"

new_file_with_content "chapters/part2/chapter1/02-technologies.typ" "
== Technology Stack Overview

This section describes the technologies used in the implementation.

=== Backend Technologies

The backend is built using modern .NET technologies:

==== ASP.NET Core 8.0

ASP.NET Core provides a high-performance, cross-platform framework for building web APIs. Key features include:

- Dependency injection built-in
- Middleware pipeline architecture
- High performance (capable of handling 7 million requests/second)
- Cross-platform support (Windows, Linux, macOS)

Example minimal API endpoint:

```csharp
app.MapGet("/api/products", async (IProductRepository repo) =>
{
    var products = await repo.GetAllAsync();
    return Results.Ok(products);
});
```

==== Entity Framework Core

Entity Framework Core (EF Core) serves as the Object-Relational Mapper (ORM). Example entity definition:

```csharp
public class Product
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public decimal Price { get; set; }
    public int StockQuantity { get; set; }
    public DateTime CreatedAt { get; set; }
}
```

==== PostgreSQL with pgvector

PostgreSQL was chosen for its robustness and the pgvector extension for vector similarity search. This enables image-based product search using machine learning embeddings.

=== Frontend Technologies

@tab-frontend-comparison compares various frontend frameworks:

#figure(
  table(
    columns: 4,
    [*Framework*], [*Performance*], [*Learning Curve*], [*Ecosystem*],
    [Vue.js], [High], [Low], [Good],
    [React], [High], [Medium], [Excellent],
    [Angular], [Medium], [High], [Good],
    [Svelte], [Very High], [Low], [Growing],
  ),
  caption: [Frontend Framework Comparison]
) <tab-frontend-comparison>

Vue.js was selected for its gentle learning curve and excellent documentation.

=== Machine Learning Stack

The ML service uses FastAPI and TensorFlow for image feature extraction:

```python
from fastapi import FastAPI
from tensorflow.keras.applications import ResNet50
import numpy as np

app = FastAPI()
model = ResNet50(weights='imagenet', include_top=False)

@app.post("/extract-features")
async def extract_features(image: UploadFile):
    # Load and preprocess image
    img_array = load_image(image)
    # Extract features
    features = model.predict(img_array)
    return {"features": features.tolist()}
```
"

new_file_with_content "chapters/part2/chapter1/03-architecture-patterns.typ" "
== Architecture Patterns

=== Microservices Architecture

The system follows a microservices approach with separate services:

- *API Service*: Main e-commerce REST API
- *ML Service*: Image processing and similarity search
- *Gateway*: YARP reverse proxy for routing

Benefits of this approach include:

1. Independent deployment
2. Technology diversity
3. Service isolation
4. Scalability

The architecture follows this microservices approach.

=== Repository Pattern

The Repository pattern provides abstraction over data access:

```csharp
public interface IRepository<T> where T : class
{
    Task<T?> GetByIdAsync(Guid id);
    Task<IEnumerable<T>> GetAllAsync();
    Task<T> AddAsync(T entity);
    Task UpdateAsync(T entity);
    Task DeleteAsync(Guid id);
}
```

=== API Gateway Pattern

YARP (Yet Another Reverse Proxy) routes requests to appropriate services:

```json
{
  "Routes": {
    "api-route": {
      "ClusterId": "api-cluster",
      "Match": { "Path": "/api/{**catch-all}" }
    },
    "ml-route": {
      "ClusterId": "ml-cluster",
      "Match": { "Path": "/ml/{**catch-all}" }
    }
  }
}
```

Performance metrics are shown in @tab-gateway-performance:

#figure(
  table(
    columns: 3,
    [*Metric*], [*Without Gateway*], [*With Gateway*],
    [Avg Response Time], [45ms], [48ms],
    [Throughput (req/s)], [5000], [4800],
    [95th Percentile], [120ms], [125ms],
  ),
  caption: [API Gateway Performance Impact]
) <tab-gateway-performance>

The overhead is minimal (< 7%) while providing routing, load balancing, and centralized authentication.
"

new_file_with_content "chapters/part2/chapter2-design.typ" "
= CHAPTER 2: DESIGN AND IMPLEMENTATION <chap2>

#include "chapter2/01-overview.typ"
#include "chapter2/02-database-design.typ"
#include "chapter2/03-api-implementation.typ"
#include "chapter2/04-frontend.typ"
"

new_file_with_content "chapters/part2/chapter2/01-overview.typ" "
== System Overview

The system architecture follows a three-tier design:

1. *Presentation Layer*: Vue.js applications (Shop and Admin)
2. *Business Logic Layer*: ASP.NET Core APIs
3. *Data Layer*: PostgreSQL database

=== Component Diagram

The main components and their interactions are:

- User interfaces communicate via HTTP/REST
- APIs use Entity Framework Core for data access
- ML service provides image similarity search
- All external access goes through the API Gateway

=== Deployment Architecture

The system can be deployed using Docker:

```yaml
version: '3.8'
services:
  postgres:
    image: pgvector/pgvector:latest
    environment:
      POSTGRES_DB: ecommerce
      POSTGRES_PASSWORD: password
  
  api:
    build: ./src/Api
    depends_on:
      - postgres
    ports:
      - "5000:8080"
  
  gateway:
    build: ./src/Gateway
    depends_on:
      - api
    ports:
      - "8080:8080"
```
"

new_file_with_content "chapters/part2/chapter2/02-database-design.typ" "
== Database Design

The database schema follows normalization principles up to 3NF.

=== Entity Relationship

Key entities include:

#figure(
  table(
    columns: 3,
    [*Entity*], [*Primary Key*], [*Description*],
    [Users], [Id (UUID)], [System users],
    [Products], [Id (UUID)], [Product catalog],
    [Orders], [Id (UUID)], [Customer orders],
    [OrderItems], [Id (UUID)], [Order line items],
    [Categories], [Id (UUID)], [Product categories],
  ),
  caption: [Database Entities Overview]
) <tab-db-entities>

=== Schema Details

==== Products Table

```sql
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INTEGER NOT NULL DEFAULT 0,
    category_id UUID REFERENCES categories(id),
    image_url VARCHAR(500),
    embedding vector(2048), -- for ML similarity search
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_embedding ON products USING ivfflat (embedding vector_cosine_ops);
```

==== Orders and OrderItems

The order structure maintains referential integrity:

```sql
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id),
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id),
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL
);
```

=== Performance Considerations

Index strategy improves query performance significantly:

- B-tree indexes on foreign keys
- IVFFlat index on vector embeddings for similarity search
- Composite indexes on frequently queried columns

Query performance comparison is shown in @tab-query-performance:

#figure(
  table(
    columns: 3,
    [*Query Type*], [*Without Index*], [*With Index*],
    [Product by Category], [1200ms], [8ms],
    [Order History], [850ms], [12ms],
    [Similar Products], [3500ms], [45ms],
  ),
  caption: [Query Performance with Indexing]
) <tab-query-performance>
"

new_file_with_content "chapters/part2/chapter2/03-api-implementation.typ" "
== API Design and Implementation

The REST API follows OpenAPI 3.0 specifications.

=== Endpoint Structure

API endpoints follow RESTful conventions:

```
GET    /api/products           - List all products
GET    /api/products/{id}      - Get single product
POST   /api/products           - Create product (admin)
PUT    /api/products/{id}      - Update product (admin)
DELETE /api/products/{id}      - Delete product (admin)

POST   /api/cart/items         - Add to cart
GET    /api/cart               - Get cart contents
DELETE /api/cart/items/{id}    - Remove from cart

POST   /api/orders             - Place order
GET    /api/orders             - Get order history
GET    /api/orders/{id}        - Get order details
```

=== Request/Response Examples

Product creation request:

```json
POST /api/products
{
  "name": "Wireless Headphones",
  "description": "High-quality bluetooth headphones",
  "price": 79.99,
  "stockQuantity": 50,
  "categoryId": "123e4567-e89b-12d3-a456-426614174000"
}
```

Response:

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "name": "Wireless Headphones",
  "price": 79.99,
  "createdAt": "2026-01-01T14:23:00Z"
}
```

=== Error Handling

The API uses Problem Details (RFC 7807) for errors:

```csharp
app.UseExceptionHandler(errorApp =>
{
    errorApp.Run(async context =>
    {
        var problem = new ProblemDetails
        {
            Status = 500,
            Title = "An error occurred",
            Detail = "Please try again later"
        };
        await context.Response.WriteAsJsonAsync(problem);
    });
});
```

=== Authentication and Authorization

JWT bearer tokens authenticate API requests:

```csharp
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new()
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidIssuer = "ecommerce-api",
            ValidAudience = "ecommerce-client"
        };
    });
```
"

new_file_with_content "chapters/part2/chapter2/04-frontend.typ" "
== Frontend Implementation

The frontend uses Vue.js 3 with the Composition API and TypeScript.

=== Component Architecture

The application follows a component-based architecture:

```
src/
├── components/
│   ├── ProductCard.vue
│   ├── ShoppingCart.vue
│   └── OrderSummary.vue
├── views/
│   ├── ProductList.vue
│   ├── ProductDetail.vue
│   └── Checkout.vue
├── stores/
│   ├── cart.ts
│   └── auth.ts
└── services/
    └── api.ts
```

=== Sample Component

Product card component with TypeScript:

```typescript
<script setup lang="ts">
import { computed } from 'vue'
import { useCartStore } from '@/stores/cart'

interface Product {
  id: string
  name: string
  price: number
  imageUrl: string
}

const props = defineProps<{ product: Product }>()
const cartStore = useCartStore()

const formattedPrice = computed(() => 
  `$${props.product.price.toFixed(2)}`
)

const addToCart = () => {
  cartStore.addItem(props.product)
}
</script>

<template>
  <Card>
    <template #header>
      <img :src="product.imageUrl" :alt="product.name" />
    </template>
    <template #title>{{ product.name }}</template>
    <template #content>
      <p class="price">{{ formattedPrice }}</p>
    </template>
    <template #footer>
      <Button @click="addToCart">Add to Cart</Button>
    </template>
  </Card>
</template>
```

=== State Management

Pinia stores manage application state:

```typescript
import { defineStore } from 'pinia'
import { ref, computed } from 'vue'

export const useCartStore = defineStore('cart', () => {
  const items = ref<CartItem[]>([])
  
  const total = computed(() => 
    items.value.reduce((sum, item) => 
      sum + item.price * item.quantity, 0
    )
  )
  
  const addItem = (product: Product) => {
    const existing = items.value.find(i => i.id === product.id)
    if (existing) {
      existing.quantity++
    } else {
      items.value.push({ ...product, quantity: 1 })
    }
  }
  
  return { items, total, addItem }
})
```

=== Performance Optimization

Optimization techniques employed:

1. *Lazy loading*: Routes loaded on demand
2. *Virtual scrolling*: For large product lists
3. *Image optimization*: WebP format with lazy loading
4. *Code splitting*: Vendor and app bundles separated

Build size comparison:

#figure(
  table(
    columns: 3,
    [*Bundle*], [*Before*], [*After Optimization*],
    [Vendor], [450 KB], [280 KB],
    [App], [320 KB], [180 KB],
    [Total], [770 KB], [460 KB],
  ),
  caption: [Bundle Size Optimization Results]
) <tab-bundle-size>
"

new_file_with_content "chapters/part2/chapter3-testing.typ" "
= CHAPTER 3: TESTING AND EVALUATION <chap3>

#include "chapter3/01-testing-goal.typ"
#include "chapter3/02-unit-tests.typ"
#include "chapter3/03-performance.typ"
"

new_file_with_content "chapters/part2/chapter3/01-testing-goal.typ" "
== Testing Methodology

A comprehensive testing strategy ensures system reliability and performance.

=== Testing Levels

The testing pyramid approach is followed:

1. *Unit Tests* (70%): Test individual components in isolation
2. *Integration Tests* (20%): Test component interactions
3. *End-to-End Tests* (10%): Test complete user workflows

=== Testing Tools

- *xUnit*: .NET unit testing framework
- *Moq*: Mocking framework for dependencies
- *Vitest*: Vue.js component testing
- *k6*: Load testing tool

=== Test Coverage Goals

Target coverage metrics:

#figure(
  table(
    columns: 3,
    [*Layer*], [*Target*], [*Achieved*],
    [Domain Logic], [90%], [92%],
    [API Controllers], [80%], [85%],
    [Repositories], [85%], [88%],
    [Vue Components], [75%], [78%],
  ),
  caption: [Code Coverage Targets and Results]
) <tab-coverage>
"

new_file_with_content "chapters/part2/chapter3/02-unit-tests.typ" "
== Unit and Integration Tests

=== Backend Unit Tests

Example product service test:

```csharp
public class ProductServiceTests
{
    [Fact]
    public async Task GetById_ExistingProduct_ReturnsProduct()
    {
        // Arrange
        var mockRepo = new Mock<IProductRepository>();
        var product = new Product 
        { 
            Id = Guid.NewGuid(), 
            Name = "Test Product" 
        };
        mockRepo.Setup(r => r.GetByIdAsync(product.Id))
            .ReturnsAsync(product);
        
        var service = new ProductService(mockRepo.Object);
        
        // Act
        var result = await service.GetByIdAsync(product.Id);
        
        // Assert
        Assert.NotNull(result);
        Assert.Equal("Test Product", result.Name);
    }
    
    [Fact]
    public async Task Create_ValidProduct_IncreasesCount()
    {
        // Test implementation
    }
}
```

=== Frontend Component Tests

Vue component testing with Vitest:

```typescript
import { describe, it, expect } from 'vitest'
import { mount } from '@vue/test-utils'
import ProductCard from '@/components/ProductCard.vue'

describe('ProductCard', () => {
  it('displays product information', () => {
    const product = {
      id: '123',
      name: 'Test Product',
      price: 29.99,
      imageUrl: '/test.jpg'
    }
    
    const wrapper = mount(ProductCard, {
      props: { product }
    })
    
    expect(wrapper.text()).toContain('Test Product')
    expect(wrapper.text()).toContain('$29.99')
  })
  
  it('emits add-to-cart event when button clicked', async () => {
    const wrapper = mount(ProductCard, {
      props: { product: { /* ... */ } }
    })
    
    await wrapper.find('button').trigger('click')
    expect(wrapper.emitted('add-to-cart')).toBeTruthy()
  })
})
```

=== Integration Tests

API integration test example:

```csharp
public class ProductsApiTests : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly HttpClient _client;
    
    public ProductsApiTests(WebApplicationFactory<Program> factory)
    {
        _client = factory.CreateClient();
    }
    
    [Fact]
    public async Task GetProducts_ReturnsSuccessAndProducts()
    {
        // Act
        var response = await _client.GetAsync("/api/products");
        
        // Assert
        response.EnsureSuccessStatusCode();
        var products = await response.Content
            .ReadFromJsonAsync<List<Product>>();
        Assert.NotNull(products);
    }
}
```
"

new_file_with_content "chapters/part2/chapter3/03-performance.typ" "
== Performance Testing and Results

=== Load Testing Methodology

k6 load testing script:

```javascript
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '1m', target: 50 },   // Ramp up
    { duration: '3m', target: 50 },   // Stay at 50 users
    { duration: '1m', target: 200 },  // Spike test
    { duration: '1m', target: 0 },    // Ramp down
  ],
  thresholds: {
    http_req_duration: ['p(95)<500'], // 95% < 500ms
    http_req_failed: ['rate<0.01'],   // <1% errors
  },
};

export default function() {
  const res = http.get('http://localhost:8080/api/products');
  check(res, {
    'status is 200': (r) => r.status === 200,
    'response time OK': (r) => r.timings.duration < 500,
  });
  sleep(1);
}
```

=== Performance Results

#figure(
  table(
    columns: 4,
    [*Endpoint*], [*Avg (ms)*], [*P95 (ms)*], [*P99 (ms)*],
    [GET /products], [42], [85], [120],
    [GET /products/:id], [18], [35], [48],
    [POST /orders], [125], [280], [450],
    [POST /cart/items], [32], [68], [95],
  ),
  caption: [API Response Time Metrics]
) <tab-response-times>

=== Database Performance

Query optimization results:

```sql
-- Before optimization
EXPLAIN ANALYZE 
SELECT * FROM products WHERE category_id = $1;
-- Execution time: 1247.283 ms

-- After adding index
CREATE INDEX idx_products_category ON products(category_id);
-- Execution time: 8.421 ms
```

Performance improvement: *99.3% faster*

=== Scalability Analysis

Horizontal scaling test results are shown in @tab-scaling:

#figure(
  table(
    columns: 4,
    [*Instances*], [*Users*], [*Throughput (req/s)*], [*Avg Response*],
    [1], [100], [1200], [85ms],
    [2], [200], [2300], [92ms],
    [3], [300], [3400], [95ms],
    [4], [400], [4500], [98ms],
  ),
  caption: [Horizontal Scaling Performance]
) <tab-scaling>

The system demonstrates near-linear scalability up to 4 instances.

=== Usability Testing

User testing with 15 participants revealed:

- *Task completion rate*: 93.3%
- *Average time to checkout*: 2min 15sec
- *System Usability Scale (SUS) score*: 78.5/100

User satisfaction ratings:

#figure(
  table(
    columns: 2,
    [*Aspect*], [*Rating (1-5)*],
    [Ease of use], [4.2],
    [Visual design], [4.5],
    [Performance], [4.7],
    [Navigation], [4.1],
    [Overall], [4.4],
  ),
  caption: [User Satisfaction Ratings]
) <tab-satisfaction>
"

new_file_with_content "chapters/part2-content.typ" "
#include "part2/chapter1-background.typ"
#include "part2/chapter2-design.typ"
#include "part2/chapter3-testing.typ"
"

new_file_with_content "chapters/part3-conclusion.typ" "
#include "part3/01-conclusion.typ"
#include "part3/02-future-work.typ"
"

new_file_with_content "chapters/part3/01-conclusion.typ" "
== I. CONCLUSION

This thesis presented the design and implementation of a comprehensive e-commerce platform using modern web technologies. The project successfully achieved its stated objectives and demonstrated the practical application of contemporary software engineering principles.

=== Summary of Achievements

The main accomplishments of this research include:

1. *Architecture Design*: Successfully implemented a microservices-based architecture separating concerns between API services, ML processing, and frontend applications. The YARP API Gateway provides efficient routing with minimal overhead (< 7%).

2. *Database Design*: Developed a normalized database schema (3NF) with PostgreSQL and pgvector extension, enabling both traditional relational queries and vector similarity search for machine learning features. Performance benchmarks showed query improvements of up to 99.3% with proper indexing.

3. *API Implementation*: Created a RESTful API following OpenAPI 3.0 specifications with comprehensive error handling, authentication via JWT, and adherence to Problem Details (RFC 7807) standards. The API demonstrates high performance with average response times under 50ms for most endpoints.

4. *Frontend Development*: Built responsive user interfaces using Vue.js 3 with the Composition API, TypeScript, and PrimeVue components. Bundle optimization reduced total application size by 40% (from 770KB to 460KB) through code splitting and lazy loading.

5. *Machine Learning Integration*: Integrated image-based product search using FastAPI and TensorFlow, demonstrating practical application of ML in e-commerce contexts.

6. *Testing and Validation*: Achieved comprehensive test coverage (85%+ across all layers) with unit, integration, and performance tests. Load testing demonstrated the system can handle 200+ concurrent users while maintaining acceptable response times (95th percentile < 500ms).

=== Contributions to the Field

This work contributes to the software engineering field in several ways:

*Educational Resource*: The project serves as a comprehensive reference implementation for students and developers learning modern web development practices. Unlike proprietary commercial platforms, this open-source approach provides transparent insight into system design decisions.

*Best Practices Demonstration*: The implementation showcases industry-standard patterns including Repository pattern, Dependency Injection, RESTful API design, and modern frontend state management.

*Performance Benchmarking*: Detailed performance metrics and optimization techniques provide valuable data for similar projects. The comparison of indexed vs. non-indexed database queries, bundle size optimization results, and horizontal scaling characteristics offer practical guidance.

*Integration Patterns*: The combination of .NET APIs, Vue.js frontends, PostgreSQL with vector extensions, and Python ML services demonstrates effective polyglot architecture design.

=== Research Questions Addressed

Returning to the initial research questions:

*Q1: Can modern microservices architecture provide both scalability and maintainability in e-commerce systems?*

Yes. The implemented architecture demonstrates near-linear horizontal scaling with minimal coupling between services. Each service can be deployed, updated, and scaled independently.

*Q2: How effective is vector similarity search for e-commerce product discovery?*

The pgvector integration shows promising results with similarity search response times averaging 45ms, making it viable for real-time product recommendations based on images.

*Q3: What are the performance trade-offs of using an API Gateway?*

Testing revealed only 6.7% average overhead (3ms) while providing significant benefits in routing, centralized authentication, and future extensibility for rate limiting and caching.

=== Limitations Acknowledged

Several limitations should be noted:

1. *Scale Testing*: Performance testing was conducted with up to 400 concurrent users. Enterprise-scale testing (10,000+ concurrent users) was not feasible within the project scope.

2. *Payment Integration*: Payment processing was simulated rather than integrated with real payment gateways due to compliance and financial constraints.

3. *Mobile Applications*: Native mobile applications were excluded from scope. The responsive web design provides mobile browser support but not native app performance.

4. *Advanced Analytics*: Business intelligence and advanced reporting features were not implemented in favor of focusing on core e-commerce functionality.

5. *Multi-tenancy*: The system supports single-tenant deployment. Multi-vendor marketplace features would require architectural extensions.

=== Lessons Learned

Key insights from this project include:

*Technical Lessons*:
- Early performance testing reveals bottlenecks before they become critical
- Database indexing strategy has dramatic impact on query performance
- Type safety (TypeScript) significantly reduces frontend bugs
- Comprehensive error handling improves debugging efficiency

*Process Lessons*:
- Incremental development with continuous testing prevents integration issues
- Clear API contracts (OpenAPI) facilitate frontend-backend parallel development
- Code reviews and automated testing maintain code quality
- Documentation should evolve with the codebase, not as an afterthought

=== Impact and Significance

This thesis demonstrates that modern e-commerce platforms can be built with:
- Open-source technologies (reducing licensing costs)
- Educational transparency (supporting learning and research)
- Production-ready quality (meeting performance and reliability standards)
- Extensible architecture (accommodating future requirements)

The project validates that academic research projects can produce practically viable software systems while maintaining rigorous engineering standards.
"

new_file_with_content "chapters/part3/02-future-work.typ" "
== II. FUTURE WORK

While this thesis achieved its primary objectives, several areas present opportunities for future research and development.

=== Technical Enhancements

==== 1. Advanced Machine Learning Features

*Product Recommendations*:
- Implement collaborative filtering based on user purchase history
- Develop hybrid recommendation systems combining content-based and collaborative approaches
- Integrate real-time personalization using user behavior analytics

*Natural Language Processing*:
- Add semantic search capabilities for product queries
- Implement chatbot assistance for customer support
- Enable multilingual support with automatic translation

*Computer Vision Extensions*:
- Visual search refinement with object detection
- Automatic image tagging and categorization
- Quality control through automated image analysis

==== 2. Performance Optimization

*Caching Strategy*:
```csharp
// Redis distributed caching
builder.Services.AddStackExchangeRedisCache(options =>
{
    options.Configuration = "localhost:6379";
    options.InstanceName = "ecommerce_";
});

// Cache frequently accessed products
public async Task<Product?> GetProductCached(Guid id)
{
    var cacheKey = $"product_{id}";
    var cached = await _cache.GetStringAsync(cacheKey);
    
    if (cached != null)
        return JsonSerializer.Deserialize<Product>(cached);
    
    var product = await _repository.GetByIdAsync(id);
    await _cache.SetStringAsync(cacheKey, 
        JsonSerializer.Serialize(product),
        new DistributedCacheEntryOptions 
        { 
            AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(15) 
        });
    
    return product;
}
```

*Database Partitioning*:
- Implement table partitioning for orders by date range
- Consider read replicas for query performance
- Explore sharding strategies for horizontal database scaling

*CDN Integration*:
- Serve static assets (images, JavaScript, CSS) from CDN
- Implement image optimization pipeline with automatic format conversion
- Use lazy loading and progressive image loading

==== 3. Security Enhancements

*Multi-Factor Authentication*:
- Add TOTP (Time-based One-Time Password) support
- Implement SMS or email verification
- Support WebAuthn/FIDO2 for passwordless login

*API Security*:
- Rate limiting per user/IP address
- Request signing for API integrity
- Enhanced input validation and sanitization
- Regular security audits and penetration testing

*Compliance*:
- GDPR compliance features (data export, right to deletion)
- PCI DSS compliance for payment processing
- Accessibility (WCAG 2.1 AA) improvements

==== 4. Monitoring and Observability

*Distributed Tracing*:
```csharp
// OpenTelemetry integration
builder.Services.AddOpenTelemetry()
    .WithTracing(builder =>
    {
        builder
            .AddAspNetCoreInstrumentation()
            .AddEntityFrameworkCoreInstrumentation()
            .AddSource("ECommerce.API");
    });
```

*Structured Logging*:
- Implement Serilog with structured logging
- Centralized log aggregation (e.g., ELK stack)
- Real-time alerting for critical errors

*Application Performance Monitoring*:
- Integrate APM tools (Application Insights, New Relic)
- Custom metrics for business KPIs
- Real-time dashboards for system health

=== Architectural Improvements

==== 1. Event-Driven Architecture

Transition to event-driven patterns for better decoupling:

```csharp
// Domain events
public class OrderPlacedEvent
{
    public Guid OrderId { get; set; }
    public Guid UserId { get; set; }
    public decimal TotalAmount { get; set; }
    pub DateTime PlacedAt { get; set; }
}

// Event publisher
public interface IEventPublisher
{
    Task PublishAsync<TEvent>(TEvent @event) where TEvent : class;
}

// Example: Trigger multiple actions on order placement
await _eventPublisher.PublishAsync(new OrderPlacedEvent
{
    OrderId = order.Id,
    UserId = order.UserId,
    TotalAmount = order.TotalAmount,
    PlacedAt = DateTime.UtcNow
});
// Handlers can update inventory, send email, update analytics, etc.
```

*Benefits*:
- Loose coupling between services
- Easier to add new features without modifying existing code
- Natural fit for microservices communication
- Better scalability through message queues

==== 2. CQRS (Command Query Responsibility Segregation)

Separate read and write models for optimization:

- Write model optimized for transactions and consistency
- Read model optimized for queries and denormalized data
- Event sourcing for audit trail and state reconstruction
- Materialized views for complex queries

==== 3. GraphQL API Option

Complement REST API with GraphQL for flexible querying:

```graphql
type Query {
  product(id: ID!): Product
  products(
    category: String
    minPrice: Float
    maxPrice: Float
    limit: Int
  ): [Product!]!
}

type Product {
  id: ID!
  name: String!
  price: Float!
  category: Category!
  relatedProducts(limit: Int): [Product!]!
}
```

*Advantages*:
- Clients specify exact data requirements
- Reduces over-fetching and under-fetching
- Single endpoint for all queries
- Strong typing and introspection

=== Business Feature Expansions

==== 1. Marketplace Features

Transform into multi-vendor platform:
- Vendor registration and management
- Commission and payment splitting
- Vendor-specific analytics
- Review and rating moderation

==== 2. Subscription and Recurring Orders

Add subscription-based products:
- Recurring payment processing
- Subscription management dashboard
- Flexible delivery scheduling
- Pause/resume/cancel workflows

==== 3. Inventory Management Enhancements

- Multi-warehouse support
- Automated reordering based on stock levels
- Barcode/QR code integration
- Real-time inventory synchronization across channels

==== 4. Advanced Marketing Features

- Discount codes and promotions engine
- Loyalty programs and reward points
- Email marketing integration
- A/B testing framework for features

=== Mobile Platform Development

==== Native Applications

Develop native mobile apps for iOS and Android:

*Technology Options*:
- React Native for cross-platform development
- Flutter for high-performance UI
- .NET MAUI for C\# developers
- Native Swift/Kotlin for platform-specific optimization

*Mobile-Specific Features*:
- Push notifications for order updates
- Mobile payments (Apple Pay, Google Pay)
- Barcode scanning for product lookup
- Offline mode with data synchronization
- Location-based features (nearby stores)

=== Research Opportunities

==== 1. Performance Studies

- Comparative analysis of different API gateway solutions
- Database performance under various indexing strategies
- Frontend framework performance comparison at scale
- Impact of caching layers on system throughput

==== 2. User Experience Research

- A/B testing different UI/UX patterns
- Accessibility evaluation with diverse user groups
- Mobile vs. desktop user behavior analysis
- Conversion rate optimization through design iterations

==== 3. Machine Learning Applications

- Demand forecasting using historical sales data
- Dynamic pricing algorithms
- Fraud detection in transactions
- Churn prediction and customer retention

==== 4. Scalability Research

- Auto-scaling strategies in cloud environments
- Cost optimization in cloud deployments
- Multi-region deployment patterns
- Disaster recovery and business continuity

=== Deployment and Operations

==== Kubernetes Orchestration

Move from Docker Compose to Kubernetes:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ecommerce-api
spec:
  replicas: 3
  selector:
    matchLabels:
      app: ecommerce-api
  template:
    metadata:
      labels:
        app: ecommerce-api
    spec:
      containers:
      - name: api
        image: ecommerce-api:latest
        ports:
        - containerPort: 8080
        env:
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: url
```

*Benefits*:
- Automatic scaling and load balancing
- Self-healing (automatic restart on failure)
- Zero-downtime deployments
- Resource optimization

==== CI/CD Pipeline Enhancement

- Automated testing in pipeline
- Container security scanning
- Infrastructure as Code (Terraform/Pulumi)
- GitOps deployment workflows

=== Concluding Remarks

The future work outlined above demonstrates that this thesis establishes a solid foundation for continued development and research. The modular architecture and adherence to best practices facilitate these extensions without requiring fundamental redesign.

Priority recommendations for immediate next steps:

1. *Short-term* (1-3 months):
   - Implement Redis caching for performance
   - Add comprehensive monitoring and logging
   - Enhance security with MFA

2. *Medium-term* (3-6 months):
   - Develop mobile applications
   - Implement advanced ML recommendations
   - Add marketplace features

3. *Long-term* (6-12 months):
   - Migrate to Kubernetes for orchestration
   - Implement event-driven architecture
   - Conduct comprehensive scalability research

The combination of technical depth, practical implementation, and extensible design positions this work as both a completed thesis project and a launchpad for future innovations in e-commerce technology.
"

write_section_header "Creating Back Matter"

new_file_with_content "backmatter/bibliography.bib" "
@article{example2023,
  author = {Author Name},
  title = {Article Title},
  journal = {Journal Name},
  year = {2023},
  volume = {10},
  pages = {1--15}
}

@book{textbook2024,
  author = {Book Author},
  title = {Book Title},
  publisher = {Publisher},
  year = {2024},
  address = {City}
}
"

new_file_with_content "backmatter/appendices.typ" "
#page[
  #set align(center)
  #text(size: 14pt, weight: "bold")[APPENDICES]
  
  #v(1cm)
  #set align(left)
  
  Appendices contain supplementary materials.
    
  = Survey Questionnaire <appendix-a>
    
  [Include your survey here]
  
  = Source Code Samples <appendix-b>
  
  [Include code samples if needed]
]
"

write_section_header "Creating Project Documentation"

new_file_with_content "README.md" "
# CTU Graduation Thesis - Typst Template

**Can Tho University** - College of Information and Communication Technology  
**Format Compliant with**: CTU Guidelines 2025-2026

## 🎓 Quick Start

### Prerequisites
- **Typst** CLI: Download from [https://github.com/typst/typst/releases](https://github.com/typst/typst/releases)
- Or use Typst web app: [https://typst.app](https://typst.app)

### Compile Your Thesis

``````powershell
# Compile once
typst compile main.typ thesis.pdf

# Watch for changes (auto-recompile)
typst watch main.typ thesis.pdf

# Or use the Makefile
make          # Compile
make watch    # Auto-recompile on changes
``````

## 📁 Project Structure

``````
$PROJECT_NAME/
├── info.typ                    # ⚙️ YOUR INFO HERE - Edit first!
├── main.typ                    # 📄 Main document file
│
├── template/                   # Template system (don't edit)
│   ├── ctu-styles.typ         # CTU formatting rules
│   └── i18n.typ               # Bilingual support
│
├── frontmatter/                # Front matter pages
│   ├── cover.typ              # Main cover page
│   ├── inner-cover.typ        # Inner cover
│   ├── abstract.typ           # Abstract (200-350 words)
│   ├── acknowledgements.typ   # Thank you section
│   ├── table-of-contents.typ  # Auto-generated TOC
│   ├── list-of-figures.typ    # Auto-generated LOF
│   ├── list-of-tables.typ     # Auto-generated LOT
│   └── abbreviations.typ      # Abbreviations list
│
├── chapters/                   # 📝 YOUR CONTENT HERE
│   ├── part1-introduction.typ # Part 1 container
│   ├── part2-content.typ      # Part 2 container
│   ├── part3-conclusion.typ   # Part 3 container
│   ├── part1/                 # Introduction sections
│   ├── part2/                 # Main chapters
│   └── part3/                 # Conclusion sections
│
├── backmatter/                 # Back matter
│   ├── bibliography.bib       # References (IEEE style)
│   └── appendices.typ         # Appendices
│
└── images/                     # 🖼️ Your figures
    ├── chapter1/
    ├── chapter2/
    └── chapter3/
``````

## ✏️ How to Write

### 1. Edit Your Information
Open ``info.typ`` and update:
- Student name, ID, class
- Thesis title
- Advisor name
- Keywords
- Abbreviations

### 2. Write Your Content
Start from Part 1:
- ``chapters/part1/01-context.typ``
- ``chapters/part1/02-related-work.typ``
- etc.

### 3. Add Figures

``````typst
#figure(
  image("../images/chapter1/diagram.png", width: 80%),
  caption: [System Architecture],
) <fig-architecture>

// Reference figures in your thesis
``````

### 4. Add Tables

``````typst
#figure(
  table(
    columns: 3,
    [Header 1], [Header 2], [Header 3],
    [Data 1], [Data 2], [Data 3],
  ),
  caption: [Test Results],
) <tab-results>
``````

### 5. Add References

Edit ``backmatter/bibliography.bib``:

``````bibtex
@article{smith2023,
  author = {Smith, John},
  title = {Example Article},
  journal = {Example Journal},
  year = {2023},
}
``````

Cite in text: ``@smith2023``

## 📐 CTU Format Compliance

This template follows **Can Tho University** official guidelines:

| Requirement | Value |
|-------------|-------|
| Font | Times New Roman |
| Size | 13pt |
| Margins | Left: 4cm, Others: 2.5cm |
| Line Spacing | 1.2 (main text) |
| Line Spacing | 1.0 (tables, figures, references) |
| Paragraph Indent | 1.0cm |
| Abstract | 200-350 words |
| Keywords | 3-5 keywords |
| Citation Style | IEEE |

## 🌐 Language Support

- **English** (default)
- **Vietnamese**

Change in ``info.typ``:
``````typst
primary_lang: "vi"  // or "en"
``````

## 🆘 Troubleshooting

### Typst not found?
Install from: https://github.com/typst/typst/releases

### PDF not generating?
Check for syntax errors in your ``.typ`` files.

### Images not showing?
- Ensure image paths are correct
- Use relative paths: ``../images/...``

## 📚 Resources

- **Typst Docs**: https://typst.app/docs
- **CTU Guidelines**: Check with your department
- **Template Issues**: Create an issue on GitHub (if applicable)

---

**Good luck with your thesis!** 🎓

Generated by CTU Thesis Generator v2.0
"

new_file_with_content ".gitignore" "
# Typst output
*.pdf

# System files
.DS_Store
Thumbs.db
desktop.ini

# Editor files
.vscode/
.idea/
*.swp
*.swo
*~

# Temporary files
*.tmp
*.bak
*.backup

# Windows thumbnail cache
Thumbs.db
ehthumbs.db

# macOS
.DS_Store
.AppleDouble
.LSOverride
"

new_file_with_content "Makefile" "
.PHONY: all watch clean help

all:
	typst compile main.typ thesis.pdf

watch:
	typst watch main.typ thesis.pdf

clean:
	@if exist thesis.pdf del thesis.pdf

help:
	@echo CTU Thesis Makefile
	@echo   make         - Compile thesis
	@echo   make watch   - Watch and auto-compile
	@echo   make clean   - Remove PDF
"

new_file_with_content "build.ps1" "
# CTU Thesis Build Script for PowerShell

param(
    [Parameter()]
    [ValidateSet("build", "watch", "clean")]
    [string]$Action = "build"
)

switch ($Action) {
    "build" {
        Write-Host "🔨 Compiling thesis..." -ForegroundColor Cyan
        typst compile main.typ thesis.pdf
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Compilation successful! Output: thesis.pdf" -ForegroundColor Green
        } else {
            Write-Host "❌ Compilation failed!" -ForegroundColor Red
        }
    }
    "watch" {
        Write-Host "👀 Watching for changes..." -ForegroundColor Cyan
        Write-Host "Press Ctrl+C to stop" -ForegroundColor Yellow
        typst watch main.typ thesis.pdf
    }
    "clean" {
        if (Test-Path "thesis.pdf") {
            Remove-Item "thesis.pdf"
            Write-Host "✅ Cleaned: thesis.pdf removed" -ForegroundColor Green
        } else {
            Write-Host "ℹ️  Nothing to clean" -ForegroundColor Gray
        }
    }
}
"

write_section_header "Finalization"

new_file_with_content "QUICKSTART.md" "
# Quick Start Guide - CTU Thesis

## Step 1: Install Typst
Download and install from: https://github.com/typst/typst/releases

## Step 2: Edit Your Info
Open ``info.typ`` and replace placeholder data with your information.

## Step 3: Compile
``````powershell
# Option 1: Using PowerShell script
.\build.ps1

# Option 2: Using Typst directly
typst compile main.typ

# Option 3: Watch mode (auto-compile)
.\build.ps1 watch
``````

## Step 4: Start Writing
Navigate to ``chapters/part1/01-context.typ`` and begin writing.

## Tips
- Compile frequently to catch errors early
- Use comments (``//``) for notes
- Keep sentences under 80 characters for better version control
- Add images to ``images/`` folders
- Update ``backmatter/bibliography.bib`` as you research

Happy writing! 🎓
"

cd ..

write_section_header "✨ Project Created Successfully!"


cd ..

# ============================================================================
# SUMMARY AND NEXT STEPS
# ============================================================================

write_section_header "✨ Project Created Successfully!"

echo ""
echo -e "\033[36m📁 Project Location:\033[0m"
echo -e "   $(pwd)/$PROJECT_NAME"
echo ""

file_count=$(find "$PROJECT_NAME" -type f 2>/dev/null | wc -l)
dir_count=$(find "$PROJECT_NAME" -type d 2>/dev/null | wc -l)

echo -e "\033[36m📊 Project Statistics:\033[0m"
echo -e "   Files created: $file_count"
echo -e "   Directories: $dir_count"
echo ""

echo -e "\033[33m🎯 Next Steps:\033[0m"
echo ""
echo -e "  1. cd $PROJECT_NAME"
echo ""
echo -e "  2. Edit info.typ with your information"
echo ""
echo -e "  3. Compile your thesis:"
echo -e "     ./build.sh"
echo -e "     or: typst compile main.typ"
echo ""
echo -e "  4. Start writing in chapters/part1/"
echo ""

echo -e "\033[32m🎓 CTU Format Compliance:\033[0m"
echo -e "   ✅ Times New Roman 13pt"
echo -e "   ✅ Margins: Left 4cm, Others 2.5cm"
echo -e "   ✅ Line spacing: 1.2"
echo -e "   ✅ Abstract: 200-350 words"
echo -e "   ✅ IEEE citation style"
echo ""

echo -e "\033[35mGood luck with your thesis! 🎉\033[0m"
echo ""
