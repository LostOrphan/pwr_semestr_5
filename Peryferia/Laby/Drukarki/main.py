import tkinter as tk
from tkinter import messagebox, ttk
import win32print

# --- Global formatting flags ---
is_bold = False
is_italic = False
is_underline = False
orientation = "portrait"  # default

def toggle_bold():
    global is_bold
    is_bold = not is_bold
    bold_btn.config(relief=tk.SUNKEN if is_bold else tk.RAISED)

def toggle_italic():
    global is_italic
    is_italic = not is_italic
    italic_btn.config(relief=tk.SUNKEN if is_italic else tk.RAISED)

def toggle_underline():
    global is_underline
    is_underline = not is_underline
    underline_btn.config(relief=tk.SUNKEN if is_underline else tk.RAISED)

def toggle_orientation():
    """Toggle between portrait and landscape orientation."""
    global orientation
    if orientation == "portrait":
        orientation = "landscape"
        orient_btn.config(text="Landscape", relief=tk.SUNKEN)
    else:
        orientation = "portrait"
        orient_btn.config(text="Portrait", relief=tk.RAISED)

def send_to_printer():
    text = text_box.get("1.0", tk.END).rstrip()
    text = text.replace("\n", "\r\n")
    if not text:
        messagebox.showwarning("Warning", "Please enter some text first.")
        return

    family = font_family_var.get()
    size = font_size_var.get()

    # --- PCL Header ---
    pcl_header = "\x1B%-12345X@PJL ENTER LANGUAGE=PCL\r\n"

    # --- Orientation codes ---
    # ESC&l0O = portrait, ESC&l1O = landscape
    pcl_orientation = "\x1B&l0O" if orientation == "portrait" else "\x1B&l1O"

    # --- Font family/typeface mapping ---
    font_map = {
        "Courier": 0,
        "Letter Gothic": 3,
        "Times New Roman": 4101,
        "Arial": 16602
    }

    typeface = font_map.get(family, 0)
    weight = 3 if is_bold else 0
    slant = 1 if is_italic else 0
    underline_on = "\x1B&d0D" if is_underline else ""
    underline_off = "\x1B&d@" if is_underline else ""

    # --- Font selection ---
    # Proportional fonts use 1p<size>v
    # Monospaced fonts use 0p10h (10 CPI)
    if family in ["Courier", "Letter Gothic"]:
        pcl_font_select = f"\x1B(s0p10h0s{weight}b{typeface}T"
    else:
        pcl_font_select = f"\x1B(s1p{size}v{slant}s{weight}b{typeface}T"

    # --- Combine all PCL parts ---
    pcl_data = (
        pcl_header +
        pcl_orientation +
        pcl_font_select +
        underline_on +
        text +
        underline_off +
        "\f" +   # form feed: end of page
        "\x1B%-12345X"  # PCL reset
    )

    try:
        printer_name = win32print.GetDefaultPrinter()
        hPrinter = win32print.OpenPrinter(printer_name)
        hJob = win32print.StartDocPrinter(hPrinter, 1, ("PCL Print Job", None, "RAW"))
        win32print.StartPagePrinter(hPrinter)
        win32print.WritePrinter(hPrinter, pcl_data.encode("utf-8"))
        win32print.EndPagePrinter(hPrinter)
        win32print.EndDocPrinter(hPrinter)
        win32print.ClosePrinter(hPrinter)
        messagebox.showinfo("Success", f"Sent to printer: {printer_name}")
    except Exception as e:
        messagebox.showerror("Error", f"Failed to send to printer:\n{e}")

# --- GUI SETUP ---
root = tk.Tk()
root.title("PCL")
root.geometry("650x550")

# Text entry
tk.Label(root, text="Enter text:", font=("Arial", 12)).pack(pady=5)
text_box = tk.Text(root, wrap="word", height=15, width=70, font=("Courier New", 11))
text_box.pack(padx=10, pady=5, fill=tk.BOTH, expand=True)

# --- Toolbar ---
toolbar = tk.Frame(root)
toolbar.pack(pady=5)

# Bold / Italic / Underline buttons
bold_btn = tk.Button(toolbar, text="Bold", command=toggle_bold, width=10)
italic_btn = tk.Button(toolbar, text="Italic", command=toggle_italic, width=10)
underline_btn = tk.Button(toolbar, text="Underline", command=toggle_underline, width=10)
orient_btn = tk.Button(toolbar, text="Portrait", command=toggle_orientation, width=10, bg="lightgray")

bold_btn.grid(row=0, column=0, padx=5)
italic_btn.grid(row=0, column=1, padx=5)
underline_btn.grid(row=0, column=2, padx=5)
orient_btn.grid(row=0, column=3, padx=5)

# --- Font selection ---
font_frame = tk.Frame(root)
font_frame.pack(pady=5)

tk.Label(font_frame, text="Font Family:", font=("Arial", 10)).grid(row=0, column=0, padx=5)
font_family_var = tk.StringVar(value="Courier")
font_family_cb = ttk.Combobox(
    font_frame, textvariable=font_family_var,
    values=["Courier", "Letter Gothic", "Times New Roman", "Arial"],
    state="readonly", width=20
)
font_family_cb.grid(row=0, column=1, padx=5)

tk.Label(font_frame, text="Font Size (points):", font=("Arial", 10)).grid(row=0, column=2, padx=5)
font_size_var = tk.StringVar(value="12")
font_size_cb = ttk.Combobox(
    font_frame, textvariable=font_size_var,
    values=["8", "10", "12", "14", "18", "24"],
    state="readonly", width=5
)
font_size_cb.grid(row=0, column=3, padx=5)

# --- Send Button ---
send_button = tk.Button(
    root, text="Send to Printer",
    command=send_to_printer,
    bg="lightblue", font=("Arial", 12)
)
send_button.pack(pady=15)

root.mainloop()
