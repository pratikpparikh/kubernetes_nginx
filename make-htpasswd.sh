#!/bin/bash
htpasswd -bc /usr/share/nginx/htpasswd $(cat ~/.kubernetes_auth | cut -d: -f 1) $(cat ~/.kubernetes_auth | cut -d: -f 2)
