import os


PROJECT_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


TEMPLATE_PATH = os.path.join(PROJECT_DIR, 'templates')


TEMPLATES = {
    'homework': os.path.join(TEMPLATE_PATH, 'homework_template.txt'),
    'problem': os.path.join(TEMPLATE_PATH, 'problem_template.txt')
}


FILE_SUBPATHS = {
    'homework': os.path.join(
        'homework', 'homework_{homework_number:02}'
    ),
    'problems': os.path.join(
        'homework', 'homework_{homework_number:02}', 'problems'
    )

}
