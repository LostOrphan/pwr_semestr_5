#!/usr/bin/env python3
import sys
import random
import time
import math
from glfw.GLFW import *

from OpenGL.GL import *
from OpenGL.GLU import *


def startup():
    update_viewport(None, 400, 400)
    glClearColor(0.5, 0.5, 0.5, 1.0)


def shutdown():
    pass

def draw_triangle(center, size):
    cx, cy = center
    h = math.sqrt(3) / 2 * size
    # Wierzchołki trójkąta równobocznego
    return [
        (cx - size / 2, cy - h / 3),
        (cx + size / 2, cy - h / 3),
        (cx, cy + 2 * h / 3)
    ]
def draw_sierpinski(vertices, depth):
    if depth == 0:
        glBegin(GL_TRIANGLES)
        for x, y in vertices:
            glVertex2f(x, y)
        glEnd()
    else:
        # Oblicz punkty środkowe boków
        midpoints = [
            ((vertices[0][0] + vertices[1][0]) / 2, (vertices[0][1] + vertices[1][1]) / 2),
            ((vertices[1][0] + vertices[2][0]) / 2, (vertices[1][1] + vertices[2][1]) / 2),
            ((vertices[2][0] + vertices[0][0]) / 2, (vertices[2][1] + vertices[0][1]) / 2),
        ]
        # Rekurencja dla trzech mniejszych trójkątów
        draw_sierpinski([vertices[0], midpoints[0], midpoints[2]], depth - 1)
        draw_sierpinski([vertices[1], midpoints[1], midpoints[0]], depth - 1)
        draw_sierpinski([vertices[2], midpoints[2], midpoints[1]], depth - 1)
def display(depth):
    glClear(GL_COLOR_BUFFER_BIT)
    glColor3f(0, 0, 1.0)  
    triangle = draw_triangle((0, 0), 150) #tablica wierzchołków trójkata
    draw_sierpinski(triangle, depth)
    glFlush()

def update_viewport(window, width, height):
    if width == 0:
        width = 1
    if height == 0:
        height = 1
    aspect_ratio = width / height

    glMatrixMode(GL_PROJECTION)
    glViewport(0, 0, width, height)
    glLoadIdentity()

    if width <= height:
        glOrtho(-100.0, 100.0, -100.0 / aspect_ratio, 100.0 / aspect_ratio,
                1.0, -1.0)
    else:
        glOrtho(-100.0 * aspect_ratio, 100.0 * aspect_ratio, -100.0, 100.0,
                1.0, -1.0)

    glMatrixMode(GL_MODELVIEW)
    glLoadIdentity()


def main():
    random.seed()
    depth=int(sys.argv[1])
    if not glfwInit():
        sys.exit(-1)

    window = glfwCreateWindow(400, 400, __file__, None, None)
    if not window:
        glfwTerminate()
        sys.exit(-1)

    glfwMakeContextCurrent(window)
    glfwSetFramebufferSizeCallback(window, update_viewport)
    glfwSwapInterval(1)

    startup()
    while not glfwWindowShouldClose(window):
        glClear(GL_COLOR_BUFFER_BIT)
        display(depth)  # Wywołanie rysowania
        glfwSwapBuffers(window)
        glfwPollEvents()

    shutdown()
    glfwTerminate()


if __name__ == '__main__':
    main()
