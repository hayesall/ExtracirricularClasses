high = 100
low = 0

print('Please think of a number between 0 and 100!')

while True:
    
    guess = ((high + low) // 2)
    
    print('Is your secret number ' + str(guess) + '?')
    hint = input("Enter 'h' to indicate the guess is too high. Enter 'l' to indicate the guess is too low. Enter 'c' to indicate I guess correctly. ")
    
    if hint == 'c':
        print('Game over. Your secret number was:', guess)
        break
    elif hint == 'h':
        high = guess
    elif hint == 'l':
        low = guess
    else:
        print('Sorry, I did not understand your input.')
