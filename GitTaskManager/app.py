
import customtkinter as ctk
from git_manager import GitManager

ctk.set_appearance_mode("dark")
ctk.set_default_color_theme("blue")

class GitTaskApp(ctk.CTk):
    def __init__(self):
        super().__init__()
        self.title("Git Task Manager - SI VII A")
        self.geometry("700x500")
        self.git = GitManager()

        self.title_label = ctk.CTkLabel(
            self, text="GIT TASK MANAGER\nSI-VII A",
            font=("Arial", 24, "bold")
        )
        self.title_label.pack(pady=20)

        self.status = ctk.CTkTextbox(self, width=600, height=220)
        self.status.pack(pady=10)

        btn_frame = ctk.CTkFrame(self)
        btn_frame.pack(pady=10)

        ctk.CTkButton(
            btn_frame, text="Cek Status Git",
            command=self.check_git
        ).grid(row=0, column=0, padx=10)

        ctk.CTkButton(
            btn_frame, text="Upload Tugas",
            command=self.upload
        ).grid(row=0, column=1, padx=10)

        ctk.CTkButton(
            btn_frame, text="Deteksi Tugas Baru",
            command=self.detect
        ).grid(row=0, column=2, padx=10)

    def show(self, text):
        self.status.delete("1.0", "end")
        self.status.insert("end", text)

    def check_git(self):
        self.show(self.git.status())

    def upload(self):
        self.show(self.git.upload())

    def detect(self):
        self.show(self.git.detect_tasks())

app = GitTaskApp()
app.mainloop()
