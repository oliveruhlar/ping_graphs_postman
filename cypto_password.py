from cryptography.fernet import Fernet
import sys 

def encrypt(message: bytes, key: bytes) -> bytes:
    return Fernet(key).encrypt(message)

def decrypt(token: bytes, key: bytes) -> bytes:
    return Fernet(key).decrypt(token)

def decoding(has):
    key = b'cdAfBIqyuqVrSnbXMFb1CQK4mrn4tbEzWWNJcYy9YZc='
    token = has.encode()
    return decrypt(token, key).decode()
