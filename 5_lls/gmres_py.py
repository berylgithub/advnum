#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Thu Jul  1 14:01:51 2021

@author: baribowo
"""

import numpy as np

def GMRes(A, b, x0, e, nmax_iter, restart=None):
    r = b - np.asarray(np.dot(A, x0)).reshape(-1)

    x = []
    q = [0] * (nmax_iter)

    x.append(r)

    q[0] = r / np.linalg.norm(r)

    h = np.zeros((nmax_iter + 1, nmax_iter))

    for k in range(nmax_iter):
        y = np.asarray(np.dot(A, q[k])).reshape(-1)

        for j in range(k+1):
            h[j, k] = np.dot(q[j], y)
            y = y - h[j, k] * q[j]
        h[k + 1, k] = np.linalg.norm(y)
        if (h[k + 1, k] != 0 and k != nmax_iter - 1):
            q[k + 1] = y / h[k + 1, k]

        b = np.zeros(nmax_iter + 1)
        b[0] = np.linalg.norm(r)
        result = np.linalg.lstsq(h, b)[0]
        print(q)
        print(h)
        print(b)
        print(result)
        x.append(np.dot(np.asarray(q).transpose(), result) + x0)
        
    return x

if __name__ == '__main__':
    A = np.matrix('1 1; 3 -4')
    b = np.array([3, 2])
    x0 = np.array([1, 2])
    
    e = 0
    nmax_iter = 2
    
    x = GMRes(A, b, x0, e, nmax_iter)
    
    print("x = ",x)