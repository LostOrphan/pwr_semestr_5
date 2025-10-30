#!/usr/bin/env python3
import sys
import random
import time
from glfw.GLFW import *

from OpenGL.GL import *
from OpenGL.GLU import *


def startup():
    update_viewport(None, 400, 400)
    glClearColor(0.5, 0.5, 0.5, 1.0)


def shutdown():
    pass

def rectangle(x,y,a,b,d,color):
    horizontal=a*d
    vertical=b*d

    glColor3f(color[0],color[1],color[2])

    glBegin(GL_TRIANGLES)
    glVertex2f(x,y)
    glVertex2f(x,y-vertical)
    glVertex2f(x+horizontal,y-vertical)
    glEnd()

    glBegin(GL_TRIANGLES)
    glVertex2f(x,y)
    glVertex2f(x+horizontal,y)
    glVertex2f(x+horizontal,y-vertical)
    glEnd()
    # time.sleep(1)
   
    render(glfwGetTime())

def render(time):
    glFlush()

def Sierpinski(x,y,dl,szer,d,color,stopien):
    if stopien == 0:
        rectangle(x, y, dl, szer, d, color)
        return
    rectangle(x, y, dl, szer, 1.0, (1.0, 1.0, 1.0))
    step = dl / 3.0
    for row in range(3):
        for col in range(3):
            if row == 1 and col == 1:
               continue
            nx = x + col * step
            ny = y - row * step
            Sierpinski(nx, ny, step, step, 1.0, color, stopien - 1)


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
    print(int(sys.argv[1]))
    random.seed()
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
        Sierpinski(-50,50,100,100,1.0,(0.0,0.0,1.0),int(sys.argv[1]))
        glfwSwapBuffers(window)
        glfwPollEvents()

    shutdown()

    glfwTerminate()


if __name__ == '__main__':
    main()
