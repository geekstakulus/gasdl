# Geekstalukus ASDL

## Description:

Geekstalukus ASDL is an AST generation tool based on the Zephyr ASDL (Abstract Syntax Description Language). It simplifies the creation of abstract syntax trees (AST) for various target languages, with a particular focus on generating V language code.

## Features:

- **ASDL-Based:** Adheres to the Zephyr ASDL syntax for defining abstract syntax trees.
- **Multi-Language Support:** Generates ASTs for various target languages, including V.
- **Easy Integration:** Provides a straightforward way to integrate AST generation into your projects.

## Installation:

To get started with Geekstalukus ASDL, clone the repository and build the project:

```bash
git clone https://github.com/yourusername/geekstalukus-asdl.git
cd geekstalukus-asdl
v run build.v
```

## Usage:

1. **Define Your ASDL Schema:** Create an ASDL definition file with your abstract syntax tree schema. Place this file in the `schemas/` directory.

2. Generate AST Code:

    Use Geekstalukus ASDL to generate code based on your ASDL schema. Run the following command:

   ```bash
   v run generate.v -schema schemas/your-schema.asdl
   ```

3. **Integrate the Generated Code:** The generated code will be placed in the `generated/` directory. You can then integrate this code into your V project or other target languages as needed.

4. **Consult Documentation:** For detailed instructions on defining ASDL schemas and using the generated code, refer to the `docs/` directory.

## Contributing:

Contributions are welcome! If you have suggestions or improvements, please follow these steps:

1. Fork the repository
2. Create a new branch (`git checkout -b feature/YourFeature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/YourFeature`)
5. Create a new Pull Request

## License:

This project is licensed under the MIT License. See the `LICENSE` file for details.
