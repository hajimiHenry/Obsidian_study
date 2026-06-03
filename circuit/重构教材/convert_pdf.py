import fitz  # PyMuPDF
import re
import os
import sys

def build_svg(pdf_path, output_dir, name):
    if not os.path.exists(pdf_path):
        print(f"[ERROR] PDF not found: {pdf_path}")
        return False
    doc = fitz.open(pdf_path)
    
    # 注入的深色自适应 CSS
    style_to_inject = """<style>
  @media (prefers-color-scheme: dark) {
    svg {
      filter: invert(1) hue-rotate(180deg) !important;
    }
  }
</style>
"""

    def process_and_save_page(page, output_svg_path):
        svg_text = page.get_svg_image()
        # 1. 自动移除全屏背景矩形，实现透明背景
        svg_text = re.sub(r'<rect[^>]*data-bg="page"[^>]*>', '', svg_text)
        svg_text = re.sub(r'<rect[^>]*fill="#(?:fff|ffffff)"[^>]*(?:width="100%"|width="[0-9.]+")[^>]*>', '', svg_text)
        
        # 2. 注入自适应深色样式
        svg_tag_match = re.search(r'<svg[^>]*>', svg_text)
        if svg_tag_match:
            svg_tag = svg_tag_match.group(0)
            svg_text = svg_text.replace(svg_tag, svg_tag + "\n" + style_to_inject)
            
        with open(output_svg_path, "w", encoding="utf-8") as f:
            f.write(svg_text)
        print(f"[INFO] Saved: {output_svg_path}")

    # 如果只有 1 页，直接保存；如果是多页，自动加上后缀 _a, _b, _c...
    if len(doc) == 1:
        process_and_save_page(doc[0], os.path.join(output_dir, f"{name}.svg"))
    else:
        suffixes = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"]
        for idx, page in enumerate(doc):
            suffix = suffixes[idx] if idx < len(suffixes) else str(idx)
            svg_path = os.path.join(output_dir, f"{name}_{suffix}.svg")
            process_and_save_page(page, svg_path)
    return True

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Usage: python convert_pdf.py <pdf_path> <output_dir> <base_name>")
        sys.exit(1)
    pdf_path = sys.argv[1]
    output_dir = sys.argv[2]
    base_name = sys.argv[3]
    build_svg(pdf_path, output_dir, base_name)
