import { sum, multiply, greet } from "../src/utils";

test("suma dos números correctamente", () => {
  expect(sum(2, 3)).toBe(5);
});

test("Multiplica dosnúmeros correctamente", () => {
  expect(multiply(2, 3)).toBe(6);
});

test("Devuelve un saludo personalizado", () => {
  expect(greet("Elu")).toBe("Hola, Elu!");
});
