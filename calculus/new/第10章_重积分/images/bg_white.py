from PIL import Image
import os
import glob

files = glob.glob('*.png')
for f in files:
    try:
        img = Image.open(f).convert('RGBA')
        white = Image.new('RGBA', img.size, (255,255,255,255))
        out = Image.alpha_composite(white, img).convert('RGB')
        out.save(f)
        print(f"Processed {f}")
    except Exception as e:
        print(f"Error processing {f}: {e}")
