#!/usr/bin/env python3
"""
AgentVerilog - Hardware Description Language Generator from Schematics
A tool for designing digital circuits visually and generating Verilog code automatically.
"""

import tkinter as tk
from tkinter import messagebox
import sys


class AgentVerilogApp:
    """Main application window for AgentVerilog hardware designer."""
    
    def __init__(self, root):
        self.root = root
        self.root.title("AgentVerilog - Hardware Designer")
        self.root.geometry("1200x800")
        
        # Configure window colors
        self.bg_color = "#1e1e1e"  # Dark background
        self.fg_color = "#ffffff"  # White foreground
        self.root.configure(bg=self.bg_color)
        
        # Initialize UI components
        self._setup_menu()
        self._setup_canvas()
        self._setup_statusbar()
        
    def _setup_menu(self):
        """Create the main menu bar with File, Edit, Tools, and Help menus."""
        menubar = tk.Menu(
            self.root, 
            bg="#2d2d2d", 
            fg=self.fg_color,
            font=("Helvetica", 12, "bold")
        )
        self.root.config(menu=menubar)
        
        # File Menu
        file_menu = tk.Menu(menubar, tearoff=0, bg="#2d2d2d", fg=self.fg_color, font=("Helvetica", 11))
        menubar.add_cascade(label="File", menu=file_menu)
        file_menu.add_command(label="New Project", command=self._new_project)
        file_menu.add_command(label="Open Project", command=self._open_project)
        file_menu.add_command(label="Save Project", command=self._save_project)
        file_menu.add_command(label="Save Project As...", command=self._save_project_as)
        file_menu.add_separator()
        file_menu.add_command(label="Export to Verilog", command=self._export_verilog)
        file_menu.add_command(label="Export to VHDL", command=self._export_vhdl)
        file_menu.add_separator()
        file_menu.add_command(label="Exit", command=self._exit_app)
        
        # Edit Menu
        edit_menu = tk.Menu(menubar, tearoff=0, bg="#2d2d2d", fg=self.fg_color, font=("Helvetica", 11))
        menubar.add_cascade(label="Edit", menu=edit_menu)
        edit_menu.add_command(label="Undo", command=self._undo)
        edit_menu.add_command(label="Redo", command=self._redo)
        edit_menu.add_separator()
        edit_menu.add_command(label="Cut", command=self._cut)
        edit_menu.add_command(label="Copy", command=self._copy)
        edit_menu.add_command(label="Paste", command=self._paste)
        edit_menu.add_separator()
        edit_menu.add_command(label="Select All", command=self._select_all)
        edit_menu.add_command(label="Delete", command=self._delete)
        
        # View Menu
        view_menu = tk.Menu(menubar, tearoff=0, bg="#2d2d2d", fg=self.fg_color, font=("Helvetica", 11))
        menubar.add_cascade(label="View", menu=view_menu)
        view_menu.add_command(label="Zoom In", command=self._zoom_in)
        view_menu.add_command(label="Zoom Out", command=self._zoom_out)
        view_menu.add_command(label="Fit to Screen", command=self._fit_screen)
        view_menu.add_separator()
        view_menu.add_command(label="Show Grid", command=self._toggle_grid)
        view_menu.add_command(label="Show Properties", command=self._toggle_properties)
        
        # Tools Menu
        tools_menu = tk.Menu(menubar, tearoff=0, bg="#2d2d2d", fg=self.fg_color, font=("Helvetica", 11))
        menubar.add_cascade(label="Tools", menu=tools_menu)
        tools_menu.add_command(label="Component Library", command=self._open_component_library)
        tools_menu.add_command(label="Simulation", command=self._open_simulation)
        tools_menu.add_command(label="Verification", command=self._open_verification)
        tools_menu.add_separator()
        tools_menu.add_command(label="Settings", command=self._open_settings)
        
        # Help Menu
        help_menu = tk.Menu(menubar, tearoff=0, bg="#2d2d2d", fg=self.fg_color, font=("Helvetica", 11))
        menubar.add_cascade(label="Help", menu=help_menu)
        help_menu.add_command(label="Documentation", command=self._open_documentation)
        help_menu.add_command(label="About", command=self._show_about)
        
    def _setup_canvas(self):
        """Create the main canvas where the schematic will be drawn."""
        self.canvas = tk.Canvas(
            self.root,
            bg=self.bg_color,
            highlightthickness=0,
            cursor="crosshair"
        )
        self.canvas.pack(fill=tk.BOTH, expand=True)
        
        # Bind events for canvas interaction
        self.canvas.bind("<Button-1>", self._on_canvas_click)
        self.canvas.bind("<B1-Motion>", self._on_canvas_drag)
        self.canvas.bind("<MouseWheel>", self._on_canvas_scroll)
        self.canvas.bind("<Button-3>", self._on_canvas_right_click)
        
    def _setup_statusbar(self):
        """Create a status bar at the bottom of the window."""
        self.statusbar = tk.Frame(self.root, bg="#2d2d2d", height=25)
        self.statusbar.pack(side=tk.BOTTOM, fill=tk.X)
        
        self.status_label = tk.Label(
            self.statusbar,
            text="Ready",
            bg="#2d2d2d",
            fg=self.fg_color,
            anchor="w",
            padx=10
        )
        self.status_label.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        
        self.coords_label = tk.Label(
            self.statusbar,
            text="X: 0, Y: 0",
            bg="#2d2d2d",
            fg=self.fg_color,
            padx=10
        )
        self.coords_label.pack(side=tk.RIGHT)
        
    # Menu command implementations
    def _new_project(self):
        """Create a new project."""
        self._update_status("New project created")
        messagebox.showinfo("New Project", "New project functionality coming soon!")
        
    def _open_project(self):
        """Open an existing project."""
        self._update_status("Opening project...")
        messagebox.showinfo("Open Project", "Open project functionality coming soon!")
        
    def _save_project(self):
        """Save the current project."""
        self._update_status("Project saved")
        messagebox.showinfo("Save Project", "Save project functionality coming soon!")
        
    def _save_project_as(self):
        """Save the current project with a new name."""
        self._update_status("Saving project as...")
        messagebox.showinfo("Save As", "Save As functionality coming soon!")
        
    def _export_verilog(self):
        """Export the schematic to Verilog code."""
        self._update_status("Exporting to Verilog...")
        messagebox.showinfo("Export Verilog", "Export Verilog functionality coming soon!")
        
    def _export_vhdl(self):
        """Export the schematic to VHDL code."""
        self._update_status("Exporting to VHDL...")
        messagebox.showinfo("Export VHDL", "Export VHDL functionality coming soon!")
        
    def _exit_app(self):
        """Exit the application."""
        if messagebox.askokcancel("Exit", "Are you sure you want to exit?"):
            self.root.quit()
            
    def _undo(self):
        """Undo the last action."""
        self._update_status("Undo action")
        
    def _redo(self):
        """Redo the last undone action."""
        self._update_status("Redo action")
        
    def _cut(self):
        """Cut selected elements."""
        self._update_status("Cut")
        
    def _copy(self):
        """Copy selected elements."""
        self._update_status("Copy")
        
    def _paste(self):
        """Paste elements from clipboard."""
        self._update_status("Paste")
        
    def _select_all(self):
        """Select all elements on the canvas."""
        self._update_status("Select all")
        
    def _delete(self):
        """Delete selected elements."""
        self._update_status("Delete")
        
    def _zoom_in(self):
        """Zoom in on the canvas."""
        self._update_status("Zooming in")
        
    def _zoom_out(self):
        """Zoom out on the canvas."""
        self._update_status("Zooming out")
        
    def _fit_screen(self):
        """Fit the entire schematic to the screen."""
        self._update_status("Fitting to screen")
        
    def _toggle_grid(self):
        """Toggle grid visibility on the canvas."""
        self._update_status("Grid toggled")
        
    def _toggle_properties(self):
        """Toggle properties panel visibility."""
        self._update_status("Properties panel toggled")
        
    def _open_component_library(self):
        """Open the component library dialog."""
        messagebox.showinfo("Component Library", "Component library coming soon!")
        
    def _open_simulation(self):
        """Open simulation tools."""
        messagebox.showinfo("Simulation", "Simulation tools coming soon!")
        
    def _open_verification(self):
        """Open verification tools."""
        messagebox.showinfo("Verification", "Verification tools coming soon!")
        
    def _open_settings(self):
        """Open settings dialog."""
        messagebox.showinfo("Settings", "Settings dialog coming soon!")
        
    def _open_documentation(self):
        """Open documentation."""
        messagebox.showinfo("Documentation", "Documentation coming soon!")
        
    def _show_about(self):
        """Show about dialog."""
        about_text = """AgentVerilog v1.0
        
A hardware design tool for creating digital circuits visually 
and generating Verilog code automatically.

© 2025 Computer Architecture Project"""
        messagebox.showinfo("About AgentVerilog", about_text)
        
    # Canvas event handlers
    def _on_canvas_click(self, event):
        """Handle canvas left-click events."""
        self._update_coords(event.x, event.y)
        self._update_status(f"Clicked at ({event.x}, {event.y})")
        
    def _on_canvas_drag(self, event):
        """Handle canvas drag events."""
        self._update_coords(event.x, event.y)
        
    def _on_canvas_scroll(self, event):
        """Handle canvas scroll/zoom events."""
        if event.delta > 0:
            self._zoom_in()
        else:
            self._zoom_out()
            
    def _on_canvas_right_click(self, event):
        """Handle canvas right-click events."""
        self._update_status(f"Right-clicked at ({event.x}, {event.y})")
        
    # Helper methods
    def _update_status(self, message):
        """Update the status bar message."""
        self.status_label.config(text=message)
        
    def _update_coords(self, x, y):
        """Update the coordinate display."""
        self.coords_label.config(text=f"X: {x}, Y: {y}")


def main():
    """Main entry point for the application."""
    root = tk.Tk()
    app = AgentVerilogApp(root)
    root.mainloop()


if __name__ == "__main__":
    main()
