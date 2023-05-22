
while True:
    print("MD Fardin Jaman Aranayak")
    print("ID:190204093/B2")
    print("Aust CSE")
    print()
    newTupleList = [('parent', 'adam', 'eve'),
                ('parent', 'adam', 'cain'),
                ('parent', 'eve', 'abel'),
                ('parent', 'eve', 'seth'),
                ('parent', 'cain', 'enoch'),
                ('parent', 'cain', 'irad'),
                ('parent', 'seth', 'noah'),
                ('parent', 'seth', 'shem'),
                ('parent', 'seth', 'ham')]

    for i in range(len(newTupleList)):
        print(newTupleList[i])
    print()

    newGenderList = [('male', 'adam'),
                 ('female', 'eve'),
                 ('male', 'cain'),
                 ('male', 'abel'),
                 ('male', 'seth'),
                 ('male', 'enoch'),
                 ('male', 'irad'),
                 ('male', 'noah'),
                 ('male', 'shem'),
                 ('male', 'ham')]
    
    for i in range(len(newGenderList)):
        print(newGenderList[i])
    print()
    #Brother or Sister
    ch = int(input("Enter your choice to find relation of \nBrother[1]\nSister[2]\nUncle[3]\nAunt[4]\nGrandparents[5]\nChoice: "))

    if ch == 1 or ch == 2:
        X = str(input("Enter the name to find the siblings: "))
        if ch == 1:
            print("Brother: ", end=' ')
        else:
            print("Sister: ", end=' ')
        for i in range(len(newTupleList)):
            if newTupleList[i][0] == 'parent' and newTupleList[i][2] == X:
                for j in range(len(newTupleList)):
                    if (
                        newTupleList[j][0] == 'parent'
                        and newTupleList[i][1] == newTupleList[j][1]
                        and newTupleList[j][2] != X
                    ):
                        for k in range(len(newGenderList)):
                            if ch == 1:
                                if (
                                    newGenderList[k][0] == 'male'
                                    and newGenderList[k][1] == newTupleList[j][2]
                                ):
                                    print(newTupleList[j][2], end=' ')
                            else:
                                if (
                                    newGenderList[k][0] == 'female'
                                    and newGenderList[k][1] == newTupleList[j][2]
                                ):
                                    print(newTupleList[j][2], end=' ')
    #Uncle or Aunt
    elif ch == 3 or ch == 4:
        X = str(input("Enter the name to find someone's uncle/aunt: "))
        if ch == 3:
            print("Uncle: ", end=' ')
        else:
            print("Aunt: ", end=' ')
        for l in range(len(newTupleList)):
            if newTupleList[l][0] == 'parent' and newTupleList[l][2] == X:
                for i in range(len(newTupleList)):
                    if newTupleList[i][0] == 'parent' and newTupleList[i][2] == newTupleList[l][1]:
                        for j in range(len(newTupleList)):
                            if (
                                newTupleList[j][0] == 'parent'
                                and newTupleList[i][1] == newTupleList[j][1]
                                and newTupleList[j][2] != newTupleList[l][1]
                            ):
                                for k in range(len(newGenderList)):
                                    if ch == 3:
                                        if (
                                            newGenderList[k][0] == 'male'
                                            and newGenderList[k][1] == newTupleList[j][2]
                                        ):
                                            print(newTupleList[j][2], end=' ')
                                    else:
                                        if (
                                            newGenderList[k][0] == 'female'
                                            and newGenderList[k][1] == newTupleList[j][2]
                                        ):
                                            print(newTupleList[j][2], end=' ')
    elif ch == 5:
        # Procedure to find the grandparents of someone
        X = str(input("Enter the name to find someone's grandparent: "))
        print('Grandparent: ', end=' ')
        for i in range(len(newTupleList)):
            if newTupleList[i][0] == 'parent' and newTupleList[i][2] == X:
                for j in range(len(newTupleList)):
                    if (
                        newTupleList[j][0] == 'parent'
                        and newTupleList[i][1] == newTupleList[j][2]
                    ):
                        print(newTupleList[j][1], end=' ')
    print("\n::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
