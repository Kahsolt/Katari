class test {

  public static int fact(int x) {
    return x == 0 ? 1 : x * fact(x - 1);
  }

  public static void main(String argv[]) {
    int x = 5;
    System.out.printf("fact(%d) = %d", x, fact(x));
  }

}