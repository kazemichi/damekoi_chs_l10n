import os
import sys
from pathlib import Path


def main():
    if len(sys.argv) < 3:
        print(f'Usage: {sys.argv[0]} <raw dir> <trans dir>')
        sys.exit(1)

    raw_dir = sys.argv[1]
    trans_dir = sys.argv[2]
    pass_dir = Path('pass')
    check_dir = Path('check')

    pass_dir.mkdir(exist_ok=True)
    check_dir.mkdir(exist_ok=True)

    for file in Path(raw_dir).glob('*.lst'):
        raw_file = Path(raw_dir) / file.name
        trans_file = Path(trans_dir) / file.name.replace('.ws2', '.wsc')
        check_file = Path(check_dir) / file.name
        pass_file = Path(pass_dir) / file.name

        with open(raw_file, 'r', encoding='utf-8') as f1, open(trans_file, 'r', encoding='utf-8') as f2:
            raw_lines = f1.readlines()
            trans_lines = f2.readlines()
            if len(raw_lines) != len(trans_lines):
                out_file = check_file
            else:
                out_file = pass_file
                if check_file.exists():
                    os.remove(check_file)
            with open(out_file, 'w', encoding='utf-8') as f3:
                for index, line in enumerate(raw_lines):
                    f3.write(line)
                    if index < len(trans_lines):
                        f3.write(trans_lines[index])
                    else:
                        f3.write('\n')

if __name__ == '__main__':
    main()
