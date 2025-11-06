#!/usr/bin/env python3
import sys

from glfw.GLFW import *
from OpenGL.GLUT import *
from OpenGL.GL import *
from OpenGL.GLU import *
import numpy as np
import math
import time

N=50
tab = np.zeros((N, N, 3), dtype=float)

u_vals = np.linspace(0.0, 1.0, N)
v_vals = np.linspace(0.0, 1.0, N)

def spin(angle):
    # glRotatef(angle, 1.0, 0.0, 0.0)
    glRotatef(angle, 0.0, 1.0, 0.0)
    # glRotatef(angle, 0.0, 0.0, 1.0)
    time.sleep(0.01)

def f(u):
    return (-90 * u**5 + 225 * u**4 - 270 * u**3 + 180 * u**2 - 45 * u)
def g(u):
    return (160 * u**4 - 320 * u**3 + 160 * u**2-5)
def fillArr():
    for i, u in enumerate(u_vals):
        for j, v in enumerate(v_vals):
            x = f(u) * math.cos(math.pi * v)
            y = g(u)
            z = f(u) * math.sin(math.pi * v)
            tab[i, j] = [x, y, z]

def startup():
    update_viewport(None, 800, 800)
    glClearColor(0.0, 0.0, 0.0, 1.0)
    glEnable(GL_DEPTH_TEST)


def shutdown():
    pass



def axes():
    glBegin(GL_LINES)

    glColor3f(1.0, 0.0, 0.0)
    glVertex3f(-5.0, 0.0, 0.0)
    glVertex3f(5.0, 0.0, 0.0)

    glColor3f(0.0, 1.0, 0.0)
    glVertex3f(0.0, -5.0, 0.0)
    glVertex3f(0.0, 5.0, 0.0)

    glColor3f(0.0, 0.0, 1.0)
    glVertex3f(0.0, 0.0, -5.0)
    glVertex3f(0.0, 0.0, 5.0)

    glEnd()


def render(time):
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    glLoadIdentity()
    glTranslatef(0.0, -2, -7.0)
    glRotatef(30, 1, 0, 0)
    spin(time*180/3.1415)
    axes()
    glColor3f(1.0, 1.0, 0.0)
    glPointSize(3.0)
    glBegin(GL_POINTS)
    for i in range(N):
        for j in range(N):
            glVertex3fv(tab[i, j])
    glEnd()
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
        glOrtho(-7.5, 7.5, -7.5 / aspect_ratio, 7.5 / aspect_ratio, 7.5, -7.5)
    else:
        glOrtho(-7.5 * aspect_ratio, 7.5 * aspect_ratio, -7.5, 7.5, 7.5, -7.5)

    glMatrixMode(GL_MODELVIEW)
    glLoadIdentity()


def main():
    if not glfwInit():
        sys.exit(-1)

    window = glfwCreateWindow(800, 800, __file__, None, None)
    if not window:
        glfwTerminate()
        sys.exit(-1)

    glfwMakeContextCurrent(window)
    glfwSetFramebufferSizeCallback(window, update_viewport)
    glfwSwapInterval(1)
    fillArr() #
    startup()
    while not glfwWindowShouldClose(window):
        render(glfwGetTime())
        glfwSwapBuffers(window)
        glfwPollEvents()
    shutdown()

    glfwTerminate()


if __name__ == '__main__':
    main()
