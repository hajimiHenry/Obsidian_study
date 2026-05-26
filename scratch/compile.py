import os
import sys
import subprocess
from PIL import Image

def main():
    if len(sys.argv) < 3:
        print("Usage: python compile.py <asy_file> <out_png> [open_after_compile=true/false]")
        sys.exit(1)
        
    asy_file = os.path.abspath(sys.argv[1])
    out_png = os.path.abspath(sys.argv[2])
    open_after = True
    if len(sys.argv) >= 4:
        open_after = sys.argv[3].lower() == 'true'
        
    if not os.path.exists(asy_file):
        print(f"Error: {asy_file} not found.")
        sys.exit(1)
        
    asy_dir = os.path.dirname(asy_file)
    asy_base = os.path.basename(asy_file)
    asy_name, _ = os.path.splitext(asy_base)
    
    # 编译命令
    print(f"Compiling {asy_file} using asymptote...")
    cmd = ["asy", "-f", "png", "-noV", asy_base]
    try:
        # 在 asy_file 所在目录执行命令
        result = subprocess.run(cmd, cwd=asy_dir, capture_output=True, text=True, check=True)
        print("Asymptote compilation successful.")
        if result.stdout:
            print("Stdout:", result.stdout)
    except subprocess.CalledProcessError as e:
        print("Error compiling asymptote file:")
        print("Exit code:", e.returncode)
        print("Stdout:", e.stdout)
        print("Stderr:", e.stderr)
        sys.exit(1)
        
    # 生成的透明PNG路径
    transparent_png = os.path.join(asy_dir, f"{asy_name}.png")
    if not os.path.exists(transparent_png):
        print(f"Error: Expected output file {transparent_png} was not created.")
        sys.exit(1)
        
    # 转为白底
    print(f"Converting {transparent_png} to white background and saving to {out_png}...")
    try:
        img = Image.open(transparent_png).convert('RGBA')
        white = Image.new('RGBA', img.size, (255, 255, 255, 255))
        out = Image.alpha_composite(white, img).convert('RGB')
        
        # 确保输出目录存在
        os.makedirs(os.path.dirname(out_png), exist_ok=True)
        out.save(out_png, "PNG")
        print("Conversion and save successful.")
        
        # 删除临时的透明PNG
        # 如果 asy_file 和 out_png 在不同位置，可选择删除透明PNG，但如果相同就保留
        if os.path.abspath(transparent_png) != os.path.abspath(out_png):
            try:
                os.remove(transparent_png)
            except Exception as ex:
                print(f"Warning: could not remove temporary file {transparent_png}: {ex}")
    except Exception as e:
        print(f"Error during post-processing: {e}")
        sys.exit(1)
        
    # 打开文件审查
    if open_after:
        print(f"Opening {out_png} for review...")
        if sys.platform == 'win32':
            os.startfile(out_png)
        else:
            subprocess.run(["open", out_png])

if __name__ == '__main__':
    main()
