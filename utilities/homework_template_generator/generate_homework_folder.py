import argparse
import os
import settings.generate


def get_arguments():
    parser_help = 'Create directory containing LaTeX document for homework '
    parser_help += 'and problem template files.'
    parser = argparse.ArgumentParser(description=parser_help)

    d_help = 'This is the directory in which to write the homework template, '
    d_help += 'e.g. ~/../gradschool/MATH671.'
    parser.add_argument('-d', '--directory', dest='root_path', help=d_help)

    n_help = 'The homework number to be written into directory and files.'
    parser.add_argument('-n', '--number', dest='homework_number', type=int,
                        help=n_help)

    p_help = 'The list of strings to write as problem numbers.'
    parser.add_argument('-p', '--problems', dest='problems', nargs='+',
                        help=p_help)

    return vars(parser.parse_args())


def create_homework_body(problems):
    lines = []

    for problem in problems:
        problem_file = 'problems/problem_{0}'.format(problem)
        line = '\input{{{0}}}'.format(problem_file)
        lines.append(line)

    body = '\n\n'.join(lines)

    return body


def get_directories(root_path, homework_number):
    directories = {}

    for template in settings.generate.FILE_SUBPATHS:
        subpath = settings.generate.FILE_SUBPATHS[template]
        subpath = subpath.format(**{'homework_number': homework_number})

        directories.update({
            template: os.path.join(os.path.abspath(root_path), subpath)
        })

    for name in directories:
        directory = directories[name]
        if not os.path.isdir(directory):
            os.makedirs(directory)

    return directories


def write_problem_file(directories, problem_number):
    with open(settings.generate.TEMPLATES['problem']) as path:
        template = path.read()

    parameters = {'problem_number': problem_number}
    problem_contents = template.format(**parameters)

    problem_path = os.path.join(
        directories['problems'],
        'problem_{problem_number}.tex'.format(**parameters)
    )

    with open(problem_path, 'w') as path:
        path.write(problem_contents)


def write_homework_file(directories, homework_number, problems):
    with open(settings.generate.TEMPLATES['homework']) as path:
        template = path.read()

    parameters = {
        'homework_number': homework_number,
        'problems': create_homework_body(problems)
    }

    homework_content = template.format(**parameters)

    homework_path = os.path.join(
        directories['homework'],
        'homework_{homework_number:02}.tex'.format(**parameters)
    )

    with open(homework_path, 'w') as path:
        path.write(homework_content)


def main(root_path, homework_number, problems):
    directories = get_directories(root_path, homework_number)
    write_homework_file(directories, homework_number, problems)
    for problem in problems:
        write_problem_file(directories, problem)


if __name__ == '__main__':
    arguments = get_arguments()

    main(**arguments)
