import subprocess, json
from pathlib import Path

class GitEngine:
    def __init__(self):
        self.config=json.loads(Path("config.json").read_text())

    def run(self,cmd):
        p=subprocess.run(
            cmd,
            shell=True,
            cwd=self.config["repository"],
            capture_output=True,
            text=True
        )
        return p.stdout+p.stderr

    def status(self):
        return self.run("git status")

    def upload(self):
        self.run("git add .")
        self.run('git commit -m "Update tugas otomatis"')
        return self.run("git push")

    def check_pr(self):
        return "Fitur cek ACC membaca Pull Request GitHub. Tambahkan GitHub Token pada konfigurasi."

    def history(self):
        return self.run("git log --oneline -10")