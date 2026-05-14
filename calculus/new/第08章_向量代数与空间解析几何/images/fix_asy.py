import os

files = [
    'plane_point_normal.asy',
    'plane_angle.asy',
    'plane_distance.asy',
    'plane_intercept.asy'
]

for fname in files:
    if not os.path.exists(fname):
        print(f'Missing: {fname}')
        continue
    with open(fname, 'r', encoding='utf-8') as f:
        content = f.read()

    original = content
    # Replace single-backslash LaTeX commands with double-backslash
    # In the source file these are literal one-backslash sequences
    content = content.replace(r'\overrightarrow', r'\\overrightarrow')
    content = content.replace(r'\mathbf', r'\\mathbf')
    content = content.replace(r'\theta', r'\\theta')
    content = content.replace(r'\Pi', r'\\Pi')

    if content != original:
        with open(fname, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f'Fixed: {fname}')
    else:
        print(f'No changes: {fname}')
