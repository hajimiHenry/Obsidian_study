import os
import subprocess
from PIL import Image

# 6个要编译的asy文件
files = [
    "polar_area_element",
    "jacobian_mapping_overview",
    "jacobian_vector_decomposition",
    "parallelogram_area_determinant",
    "polar_jacobian_verification"
]

images_dir = r"C:\Users\Spane\Desktop\prompt_base\calculus\new\第10章_重积分\images"
desktop_dir = r"C:\Users\Spane\Desktop"

print("开始编译 Asymptote 文件...")

for name in files:
    asy_file = os.path.join(images_dir, f"{name}.asy")
    print(f"正在编译: {name}.asy...")
    
    # 编译命令：asy -f png -noV "path\to\file.asy"
    # 我们cd到images目录运行，这样输出就会在images目录
    try:
        res = subprocess.run(
            ["asy", "-f", "png", "-noV", f"{name}.asy"],
            cwd=images_dir,
            capture_output=True,
            text=True,
            check=True
        )
        print(f"  编译成功: {name}.png")
    except subprocess.CalledProcessError as e:
        print(f"  编译失败: {name}.asy")
        print("  错误输出:")
        print(e.stderr)
        continue

    # 透明底转白底
    png_path = os.path.join(images_dir, f"{name}.png")
    if not os.path.exists(png_path):
        print(f"  未找到生成的图片: {png_path}")
        continue
        
    print(f"  开始合成白底: {name}.png")
    try:
        img = Image.open(png_path).convert('RGBA')
        white = Image.new('RGBA', img.size, (255, 255, 255, 255))
        out = Image.alpha_composite(white, img).convert('RGB')
        
        # 保存到 images 目录
        out.save(png_path)
        print(f"    已保存白底图片到: {png_path}")
        
        # 保存副本到桌面
        desktop_path = os.path.join(desktop_dir, f"{name}.png")
        out.save(desktop_path)
        print(f"    已保存桌面副本: {desktop_path}")
    except Exception as ex:
        print(f"  转换白底时发生错误: {ex}")

print("\n全部处理完毕！")
