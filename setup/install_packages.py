import re

with open("packages.py", "r") as f:
    lines = f.read().splitlines()
    
    pkg_arch = []
    pkg_arch_asdeps = []
    pkg_aur = []
    pkg_aur_asdeps = []
    pkg_cargo = []
    
    input_received = False
    finally_print = []
    
    for line in lines:
        line = re.sub(r"\s*#.*", "", line).strip()
        
        if not line:
            continue
        
        if line[0] == "@":
            if line[1] == "?":
                pkg_aur_asdeps.append(line[2:].strip())
            else:
                pkg_aur.append(line[1:].strip())
        elif line[0] == "%":
            pkg_cargo.append(line[1:].strip())
        elif line[0] == "<":
            input_received = True
            input(line)
        elif line[0] == ">":
            finally_print.append(line)
        else:
            if line[0] == "?":
                pkg_arch_asdeps.append(line[1:].strip())
            else:
                pkg_arch.append(line.strip())
    
    if input_received:
        print()
    
    # Remove duplicates
    pkg_arch = list(dict.fromkeys(pkg_arch))
    pkg_arch_asdeps = list(dict.fromkeys(pkg_arch_asdeps))
    pkg_aur = list(dict.fromkeys(pkg_aur))
    pkg_aur_asdeps = list(dict.fromkeys(pkg_aur_asdeps))
    pkg_cargo = list(dict.fromkeys(pkg_cargo))
    
    if pkg_arch:
        print(f"sudo pacman -S --asexplicit {' '.join(pkg_arch)}\n")
    
    if pkg_aur:
        print(f"paru -S --asexplicit {' '.join(pkg_aur)}\n")
    
    if pkg_arch_asdeps:
        print(f"sudo pacman -S --asdeps --needed {' '.join(pkg_arch_asdeps)}\n")
    
    if pkg_aur_asdeps:
        print(f"paru -S --asdeps --needed {' '.join(pkg_aur_asdeps)}\n")
    
    if pkg_cargo:
        print(f"cargo install {' '.join(pkg_cargo)}\n")
    
    for s in finally_print:
        print(s)
