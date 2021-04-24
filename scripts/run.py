import sys
import os
import subprocess
import shutil

curr_dir = os.path.dirname(os.path.dirname(os.path.realpath(__file__)))
tmp_dir = os.path.join(curr_dir, "tmp")
bin_dir = os.path.join(curr_dir, "bin")
data_dirname = "data"

gitignore_value = """
*
!.keep
!.gitignore
"""

def copy_data_dir(relative_dir, bin_dir):
    relative_data_dir = os.path.join(relative_dir, data_dirname)
    bin_data_dir = os.path.join(bin_dir, data_dirname)
    if os.path.exists(bin_data_dir):
        try:
            shutil.rmtree(bin_data_dir)
        except:
            os.remove(bin_data_dir)
    if os.path.exists(relative_data_dir):
        print("Copying data dir {}".format(relative_data_dir))
        shutil.copytree(relative_data_dir, bin_data_dir)
    

def write_gitignore(directory):
    gitignore_file = os.path.join(directory, ".gitignore")
    with open(gitignore_file, "w") as f:
        f.write(gitignore_value)

if not os.path.exists(tmp_dir):
    os.mkdir(tmp_dir)
    write_gitignore(tmp_dir)

if not os.path.exists(bin_dir):
    os.mkdir(bin_dir)
    write_gitignore(bin_dir)

def compile(haskell_file, relative_path, binary):
    tmp_relative_dir = os.path.join(tmp_dir, relative_path)
    if not os.path.exists(tmp_relative_dir):
        os.makedirs(tmp_relative_dir)
    cmd = ["ghc", "-o", binary, "-hidir", tmp_relative_dir,  "-tmpdir", tmp_relative_dir, "-odir", tmp_relative_dir, haskell_file]
    subprocess.call(cmd)

def run(binary, extra_args, file_to_compile, debug):
    print("Running {} with args: {}".format(binary, extra_args))
    cmd = ["{}".format(binary)] + extra_args
    if debug:
        cmd = ["ghci", file_to_compile]
    
    subprocess.call(cmd)

if len(sys.argv) < 2:
    raise Exception("Needs haskell file to run and compile e.g. 01.hs")

extra_args = []
if len(sys.argv) > 2:
    extra_args = sys.argv[2:]

debug = False
if "--debug" in extra_args:
    extra_args.remove("--debug")
    debug = True

file_to_compile = os.path.join(curr_dir, sys.argv[1])
relative_path = file_to_compile.replace(curr_dir, '')[1:]
relative_dir = os.path.dirname(relative_path)
base_file_name = os.path.basename(file_to_compile)

binary_file_name = base_file_name.split('.')[0]
binary_dir_name = os.path.join("bin", relative_dir)

if not os.path.exists(binary_dir_name):
    os.makedirs(binary_dir_name)
  

binary_file_path = os.path.join(binary_dir_name, binary_file_name)

if not os.path.exists(file_to_compile):
    raise Exception("Ensure {} exists".format(file_to_compile))

copy_data_dir(relative_dir, binary_dir_name)
compile(file_to_compile, relative_dir, binary_file_path)
run(binary_file_path, extra_args, file_to_compile, debug)



