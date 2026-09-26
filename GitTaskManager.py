
import os
import subprocess
import tkinter as tk
from tkinter import filedialog, messagebox
from datetime import datetime


class GitTaskManager:
    def __init__(self):
        self.root = tk.Tk()
        self.root.title("Git Task Manager - SI VII A")
        self.root.geometry("850x600")
        self.root.configure(bg="#1e1e1e")

        self.repo_path = ""

        self.title = tk.Label(
            self.root,
            text="GIT TASK MANAGER\nSI VII A",
            font=("Arial", 24, "bold"),
            fg="white",
            bg="#1e1e1e"
        )
        self.title.pack(pady=20)

        self.path_label = tk.Label(
            self.root,
            text="Repository belum dipilih",
            fg="#00ff99",
            bg="#1e1e1e",
            font=("Arial", 11)
        )
        self.path_label.pack()

        tk.Button(
            self.root,
            text="Pilih Repository",
            command=self.choose_repo,
            width=20
        ).pack(pady=10)

        self.output = tk.Text(
            self.root,
            width=90,
            height=20,
            bg="#111111",
            fg="white"
        )
        self.output.pack(pady=10)

        frame = tk.Frame(self.root, bg="#1e1e1e")
        frame.pack()

        buttons = [
            ("Cek Git", self.check_git),
            ("Upload Tugas", self.upload),
            ("Deteksi Tugas", self.detect_task),
            ("Riwayat Commit", self.history)
        ]

        for text, command in buttons:
            tk.Button(
                frame,
                text=text,
                command=command,
                width=18
            ).pack(side="left", padx=5)

        self.write("Silakan pilih folder repository SI-VIIA-Mobile")

        self.root.mainloop()

    def write(self, text):
        self.output.delete("1.0", tk.END)
        self.output.insert(tk.END, text)

    def run_git(self, command):
        if not self.repo_path:
            return "Repository belum dipilih"

        try:
            result = subprocess.run(
                command,
                cwd=self.repo_path,
                shell=True,
                capture_output=True,
                text=True
            )
            return result.stdout + result.stderr
        except Exception as e:
            return str(e)

    def choose_repo(self):
        folder = filedialog.askdirectory()

        if folder:
            self.repo_path = folder
            self.path_label.config(text=folder)
            self.write("Repository dipilih:\n" + folder)

    def check_git(self):
        self.write(self.run_git("git status"))

    def upload(self):
        if not self.repo_path:
            self.write("Pilih repository terlebih dahulu")
            return

        self.run_git("git add .")

        message = "Update tugas " + datetime.now().strftime("%d-%m-%Y %H:%M")

        self.run_git(
            f'git commit -m "{message}"'
        )

        result = self.run_git("git push")

        self.write(
            "UPLOAD SELESAI\n\n" + result
        )

    def detect_task(self):
        if not self.repo_path:
            self.write("Pilih repository terlebih dahulu")
            return

        data = []

        for item in os.listdir(self.repo_path):
            if item.lower().startswith("tugas"):
                data.append("📁 " + item)

        if data:
            self.write(
                "Tugas ditemukan:\n\n" +
                "\n".join(data)
            )
        else:
            self.write("Belum ada folder tugas")

    def history(self):
        self.write(
            self.run_git(
                "git log --oneline -10"
            )
        )


if __name__ == "__main__":
    GitTaskManager()
