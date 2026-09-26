import customtkinter as ctk
from git_engine import GitEngine

ctk.set_appearance_mode("dark")
ctk.set_default_color_theme("blue")

class App(ctk.CTk):
    def __init__(self):
        super().__init__()
        self.title("Git Task Manager V3 - SI VII A")
        self.geometry("900x650")
        self.git = GitEngine()

        ctk.CTkLabel(
            self,
            text="GIT TASK MANAGER V3\nSI VII A",
            font=("Arial", 28, "bold")
        ).pack(pady=20)

        self.repo = ctk.CTkEntry(self, width=600)
        self.repo.insert(0, self.git.config["repository"])
        self.repo.pack(pady=10)

        self.output = ctk.CTkTextbox(self, width=750, height=300)
        self.output.pack(pady=20)

        frame = ctk.CTkFrame(self)
        frame.pack()

        buttons = [
            ("Cek Git", self.check),
            ("Upload Tugas", self.upload),
            ("Cek ACC Dosen", self.acc),
            ("Riwayat", self.history)
        ]

        for i,(t,c) in enumerate(buttons):
            ctk.CTkButton(frame,text=t,command=c).grid(row=0,column=i,padx=10)

    def show(self,x):
        self.output.delete("1.0","end")
        self.output.insert("end",x)

    def check(self):
        self.show(self.git.status())

    def upload(self):
        self.show(self.git.upload())

    def acc(self):
        self.show(self.git.check_pr())

    def history(self):
        self.show(self.git.history())

App().mainloop()