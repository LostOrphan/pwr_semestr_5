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

def rectangle(x,y,a,b,d):
    horizontal=(a*d)+glfwGetTime()  #rozszerzają się z czasem trwania programu
    vertical=(b*d)+glfwGetTime()    #rozszerzają się z czasem trwania programu
    colorR=random.random()
    colorG=random.random()
    colorB=random.random()
    # glClear(GL_COLOR_BUFFER_BIT)

    glColor3f(colorR,colorG,colorB)
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
    time.sleep(1)
   
    render(glfwGetTime())

def render(time):
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
        rectangle(-50,50,50,25,0.5)
        rectangle(-50,-50,50,25,1)
        glfwSwapBuffers(window)
        glfwPollEvents()

    shutdown()

    glfwTerminate()


if __name__ == '__main__':
    main()
