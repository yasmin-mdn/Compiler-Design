def main():
    entered_word = input()
    state=0
    i=0
    nextchar=entered_word[i]
    while(i!=len(entered_word)):
        nextchar = entered_word[i]
        i+=1
        if(state == 0):
            if (nextchar == '0'):
                state = 0
                continue
            elif (nextchar == '1'):
                state = 1
                continue
        if(state == 1):
            if (nextchar == '0'):
                state = 0
                continue
            elif (nextchar == '1'):
                state = 2
                continue

        if(state == 2):
            if (nextchar == '0'):
                state = 3
                continue
            elif (nextchar == '1'):
                state = 1
                continue

        if (state == 3):
            if (nextchar == '0'):
                state=0
                continue
            elif (nextchar == '1'):
                state = 4
                continue
    if state != 4:
        print("accepted")
    else:
        print("rejected")


if __name__ == '__main__':
    main()