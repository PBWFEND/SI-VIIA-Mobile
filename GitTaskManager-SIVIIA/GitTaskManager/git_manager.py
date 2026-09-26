
import subprocess
from pathlib import Path

class GitManager:
    def run(self, cmd):
        try:
            result = subprocess.run(
                cmd,
                shell=True,
                capture_output=True,
                text=True
            )
            return result.stdout + result.stderr
        except Exception as e:
            return str(e)

    def status(self):
        return self.run("git status")

    def upload(self):
        self.run("git add .")
        self.run('git commit -m "Update tugas otomatis"')
        return self.run("git push")

    def detect_tasks(self):
        tugas = []
        for folder in Path(".").glob("tugas-*"):
            if folder.is_dir():
                tugas.append("📁 " + folder.name)

        if not tugas:
            return "Tidak ada folder tugas baru."

        return "Tugas ditemukan:\n\n" + "\n".join(tugas)
