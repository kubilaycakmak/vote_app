import face_recognition as fr

known_faces = [('Kubilay', 'kubilay.jpg'),
               ('Kubilay', 'kubilay2.jpg'),
               ]


def compare_faces(file1, file2):
    image1 = fr.load_image_file(file1)

    image2 = fr.load_image_file(file2)

    image1_encoding = fr.face_encodings(image1)[0]
    image2_encoding = fr.face_encodings(image2)[0]
    results = fr.compare_faces([image1_encoding], image2_encoding)
    return results[0]


def face_rec(file):
    for name, known_file in known_faces:
        if compare_faces(known_file, file):
            return name
    return 'Unknown'
