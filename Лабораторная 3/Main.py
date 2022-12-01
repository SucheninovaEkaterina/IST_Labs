import yaml

def open_file():
    with open('basa.yaml', encoding="utf8") as file:
        documents = yaml.full_load(file)
    return documents
def Vvod_obj():
    print("Объекты:")
    documents=open_file()
    for item, doc in documents.items():
        if(item=="Objects"):
            i=1
            for k in doc:
                print(f"{i}: {k}")
                i+=1
def Vvod_sv():
    print("Связи:")
    documents=open_file()
    for item, doc in documents.items():
        if(item=="Connection"):
            p=''
            j=1
            for i in range(len(doc)):
                tr=documents["Connection"][i]["type"]
                if (tr!=p):
                    p=tr
                    print(f"{j}: {p}")
                    j+=1
def per(num):
    documents=open_file()
    for item, doc in documents.items():
        p='';j=0
        for i in range(len(doc)):
            tr = documents["Connection"][i]["type"]
            if (tr != p):
                p = tr
                j+=1
                if(j==num):
                    return tr
def per_2(num):
    documents=open_file()
    for item, doc in documents.items():
        if(item=="Objects"):
            i=0
            for k in doc:
                i+=1
                if (i == num):
                    return k
def poisk_sv(num_obj, num_sv):
    documents = open_file()
    for item, doc in documents.items():
        if (item == "Connection"):
            i=0
            while( i < len(doc)):
                tr=documents["Connection"][i]["type"]
                pr=documents["Connection"][i]["src"]
                pr2=documents["Connection"][i]["dst"]
                if((pr==num_obj and pr2!=num_obj and tr==num_sv) or (pr!=num_obj and pr2==num_obj and tr==num_sv)):
                    print(documents["Connection"][i])
                i+=1
Vvod_obj()
obj_ind=int(input(f"Введите число (индекс объекта):"))
Vvod_sv()
sva_ind = int(input(f"Введите число :"))
poisk_sv(per_2(obj_ind), per(sva_ind))