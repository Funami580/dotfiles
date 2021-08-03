import re

with open("packages.py", "r") as f:
    lines = f.read().splitlines()
    
    pkg_arch, pkg_aur, pkg_cargo = [], [], []
    input_received = False
    finally_print = []
    
    for line in lines:
        line = re.sub(r"\s*#.*", "", line).strip()
        
        if not line:
            continue
        
        if line[0] == "@":
            pkg_aur.append(line[1:].strip())
        elif line[0] == "%":
            pkg_cargo.append(line[1:].strip())
        elif line[0] == "<":
            input_received = True
            input(line)
        elif line[0] == ">":
            finally_print.append(line)
        else:
            pkg_arch.append(line.strip())
    
    if input_received:
        print()
    
    # Remove duplicates
    pkg_arch = list(dict.fromkeys(pkg_arch))
    pkg_aur = list(dict.fromkeys(pkg_aur))
    pkg_cargo = list(dict.fromkeys(pkg_cargo))
    
    print(f"sudo pacman -S {' '.join(pkg_arch)}\n")
    print(f"paru -S {' '.join(pkg_aur)}\n")
    print(f"cargo install {' '.join(pkg_cargo)}\n")
    
    for s in finally_print:
        print(s)
