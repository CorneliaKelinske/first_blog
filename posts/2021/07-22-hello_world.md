==title==
Where to start?

==author==
Cornelia Kelinske

==description==
From translating to writing code. The beginning of my coding journey.


==tags==
personal,coding, brostuff

==body==

My coding journey began with....  

                                
# a friendly "Hello World"


... printed in Python way back in 2018. My husband, who at that time worked as an HVAC mechanic, had just discovered coding for himself and
challenged me to try it as well. What can I say? I am very competitive and at some point said jokingly that one day I would be better at it than him.
(While I have certainly not lived up to that challenge in general, I can say that I at least got better at Python than him, simply due to my stubbornness, which
kept me coding in Python for a long time, while my husband quickly moved on to Ruby and then Elixir.)
At first, the reason why I enjoyed coding was not so much the fact that I could use my code to actually do stuff (because, to be honest, I really didn't), 
but the pure problem-solving aspect of it. 


For the next few years, I kept coding on the back-burner. I tried to fit a short session in every day, but my translation business was thriving and I didn't have any
real coding goals or projects. I completed the Complete Python Bootcamp on [udemy](https://www.udemy.com/), taught by Colt Steele, an amazing teacher (check out his YouTube
channel: (https://www.youtube.com/c/ColtSteeleCode), and I kept solving the exercises on the [exercism](https://exercism.io/) python track, but at that time, my relationship to code was certainly lacking passion.

And then something happened: I actually used python to build something, namely an MRV calculator. For everyone who is not familiar with the whole strength training 
vocabulary:
MRV stands for Maximum Recoverable Volume. It means the maximum number of hard working sets that you can do each week and that your body can recover from so you can still build muscle and get stronger. It is really well explained in the [Scientific Principles of Strength Training] (https://www.youtube.com/watch?v=k7_kCLHOl_0&list=PL1rSl6Pd49IlsiAgFRWNI1ruDGNrMJ092) video series by Juggernaut Training systems, which was in fact the inspiration for my little project. Fun fact: when I started using the Juggernaut AI training spreadsheets for my lifting, I compared the numbers that I got out of my MRV calculator with the MRV values listed for me in the excel files, and lo and behold, they did match!  

And here, without further ado, the MRV calculator in HORRIBLE python spaghetti code...



```
#variables
gender = input("What is your gender? [m/f] ")
weight = int(input("What is your weight in pounds? [number only] "))
height = int(input("How tall are you in cm? [number only] "))
exp = int(input("For how many years have you been strength training? [number only] "))
age = int(input("How old are you? [number only] "))
diet = input("How is your diet? \na: poor \nb: average \nc: good \n[a b or c] ")
sleep = int(input("How many hours of sleep do you usually get? [number only] "))
stress = input("How much stress do you experience in your daily life? \na: a lot \nb: average \nc: not much \n[a b or c] ")
recov = input("How is your recovery?  \na: poor \nb: average \nc: good \n [a b or c] ")

Hyper_MRV_av = {"Hypertrophy Squat:" : 13, "Hypertrophy Bench:" : 17, "Hypertrophy Deadlift:" : 9}
Strength_MRV_av = {"Strength Squat:" : 9, "Strength Bench:" : 12, "Strength Deadlift:" : 6}
Peak_MRV_av = {"Peaking Squat:" : 5, "Peaking Bench:" : 6, "Peaking Deadlift:" : 3}

phases = [Hyper_MRV_av, Strength_MRV_av, Peak_MRV_av]

print("Your MRVs are as follows:")

for phase in phases:
    for lift, MRV in phase.items():
        if gender == "f":
            MRV +=5
        else:
            MRV = MRV

        if weight < 148:
            MRV += 4
        elif weight in range(148, 165):
            MRV += 2
        elif weight in range(165,221):
            MRV -=2
        else:
            MRV -=4

        if height < 160:
            MRV += 2
        elif height in range (160,176):
            MRV += 1
        elif height in range (176, 191):
            MRV -= 1
        else:
            MRV -=2

        if exp < 4 or exp in range (9, 13):
            MRV = MRV
        elif exp in range (4, 9):
            MRV += 2
        else:
            MRV -= 2

        if age < 19:
            MRV += 2
        elif age in range (19, 30):
            MRV += 1
        elif age in range (30, 40):
            MRV = MRV
        elif age in range (40, 50):
            MRV -= 2
        else:
            MRV -=4

        if diet == "a":
            MRV -= 3
        elif diet == "b":
            MRV = MRV
        else:
            MRV += 1

        if sleep < 6:
            MRV -= 3
        elif sleep > 8:
            MRV += 1
        else:
            MRV = MRV

        if stress == "a":
            MRV -= 3
        elif stress == "b":
            MRV = MRV
        else:
            MRV += 1

        if recov == "a":
            MRV -= 3
        elif recov == "b":
            MRV = MRV
        else:
            MRV += 1
        
        print(lift, MRV)

```

While this code is not pretty, it gave me my first little taste of what it feels like to use code for something that I am passionate about.

Fast forward to 2020/2021: within a few months my translation business changed rapidly. 




