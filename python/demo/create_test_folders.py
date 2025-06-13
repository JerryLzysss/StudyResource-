import os

'''
    作用;在路径下创建一系列文件夹
'''
def create_test_folders(base_path, num_folders):
    """
    在指定路径下创建一系列测试文件夹
    
    参数:
        base_path (str): 基础路径
        num_folders (int): 要创建的文件夹数量
    """
    # 确保基础路径存在
    if not os.path.exists(base_path):
        os.makedirs(base_path)
    
    # 创建测试文件夹
    for i in range(1, num_folders + 1):
        folder_name = f"TEST{i}"
        folder_path = os.path.join(base_path, folder_name)
        
        # 如果文件夹不存在，则创建
        if not os.path.exists(folder_path):
            os.makedirs(folder_path)
            print(f"已创建文件夹: {folder_path}")
        else:
            print(f"文件夹已存在: {folder_path}")

if __name__ == "__main__":
    # 设置要创建文件夹的基础路径
    base_directory = "./2"  # 可以修改为您想要的路径
    
    # 设置要创建的文件夹数量
    number_of_folders = 50  # 可以修改为您想要的数量
    
    # 创建文件夹
    create_test_folders(base_directory, number_of_folders) 