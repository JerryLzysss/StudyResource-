import os
import shutil
from pathlib import Path

'''
    作用:将目录下所有文件夹的文件移动到该文件的根目录
'''


def move_files_to_script_dir():
    # 获取脚本所在目录
    script_dir = Path(__file__).parent.absolute()
    
    # 遍历当前目录及其子目录
    for root, dirs, files in os.walk(script_dir):
        # 跳过脚本所在目录
        if root == str(script_dir):
            continue
            
        # 移动文件
        for file in files:
            source_path = os.path.join(root, file)
            target_path = os.path.join(script_dir, file)
            
            # 如果目标文件已存在，添加数字后缀
            if os.path.exists(target_path):
                base, ext = os.path.splitext(file)
                counter = 1
                while os.path.exists(target_path):
                    new_name = f"{base}_{counter}{ext}"
                    target_path = os.path.join(script_dir, new_name)
                    counter += 1
            
            try:
                shutil.move(source_path, target_path)
                print(f"已移动: {source_path} -> {target_path}")
            except Exception as e:
                print(f"移动文件 {source_path} 时出错: {str(e)}")

if __name__ == "__main__":
    move_files_to_script_dir()