import os
import sys
import time
from PIL import Image

def main():
    # 切换当前工作目录到脚本所在目录
    script_dir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(script_dir)
    
    files = [
        "line_integral_first_3d",
        "line_integral_second_3d",
        "greens_theorem_2d",
        "surface_integral_first_3d",
        "surface_integral_second_3d",
        "gauss_divergence_3d",
        "stokes_theorem_3d"
    ]
    
    print("开始编译 Asymptote 图片...")
    
    # 确保 images 目录存在
    if not os.path.exists("images"):
        os.makedirs("images")
        
    for f in files:
        asy_path = f"images/{f}.asy"
        png_path = f"images/{f}.png"
        
        # 编译命令：asy -f png -noV -o images/images/xx 还是 images/xx？
        # 最稳妥的办法是 cd 到 images 目录，然后编译，这样生成的文件就在 images 目录下
        print(f"正在编译: {f}.asy ...")
        cmd = f'cd images && asy -f png -noV {f}.asy'
        ret = os.system(cmd)
        if ret != 0:
            print(f"警告: {f}.asy 编译失败！错误代码: {ret}")
            continue
            
        if not os.path.exists(png_path):
            print(f"错误: 找不到生成的图片 {png_path}！")
            continue
            
        # 使用 Pillow 处理为纯白底 PNG
        try:
            img = Image.open(png_path).convert("RGBA")
            white = Image.new("RGBA", img.size, (255, 255, 255, 255))
            out = Image.alpha_composite(white, img).convert("RGB")
            
            # 保存回原处
            out.save(png_path)
            print(f"成功转换白底并保存至: {png_path}")
            
            # 保存副本到桌面
            desktop_path = f"C:/Users/Spane/Desktop/{f}.png"
            out.save(desktop_path)
            print(f"成功保存桌面副本至: {desktop_path}")
            
            # 启动图片查看器进行自我审查
            os.system(f'start "" "{desktop_path}"')
            time.sleep(0.5) # 稍微延迟一下避免启动冲突
        except Exception as e:
            print(f"处理图片 {f}.png 出错: {e}")
            
    print("所有插图编译与白底后处理完成！")

if __name__ == "__main__":
    main()
