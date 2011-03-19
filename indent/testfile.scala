/**
 * Commets are here
 */
class SomeClass {
  val someval = SomeObject.makeWithSomething
  var somevar = SomeObject.makeWithSomething

  def someBracedDef = {
    case ASingleLineCase => a.statement

    case AMultiLineCase =>
      if (this)
        then
      else // This doesn't dedent immediately
        that
  }

  def aSingleLineDef = someval + 12

  def main(args: Array[String]) = run(20000, 20000)

  // This
  def aMultiLineSingleStatementDefWithBraces = {
    SomeObject.makeWithSomething
  }

  // This
  def aMultiLineSingleStatementDefWithNoBraces =
    new X {
      def something = 5
    }

  def aMultiLineSingleStatementDefWithNoBraces =
    SomeObject.makeWithSomething

  def someFunc = {
    if (b) 1
    else {
      if (b) 2
      else
        3
    }
  }

  def someOtherFunc =
    if (this)
      that
    else
      theOther

  def someOtherOtherFunc = {
    if (b) 1
    else {
      if (b) 2
      else
        3
    }

    /**
     * The following stuff doesn't work, but honestly, it's pretty
     * pathological stuff... format your code differently.
     *
     * ---- 1. ----
     *
     *    if (b) 1
     *    else
     *      if (c) 2
     *    else 3 // Should be the same as the above 'if'
     *
     *    Do this instead:
     *
     *    if (b) 1
     *    else {
     *      if (c) 2
     *      else 3
     *    }
     *    
     *
     * ---- 2. ----
     *
     *    if (b) 1
     *    else
     *      if (c)
     *        2
     *        else 3
     *
     *    Do this instead:
     *
     *    if (b) 1
     *    else {
     *      if (c) 2
     *      else 3
     *    }
     *
     *    or this...
     *    
     *    if (b) 1
     *    else {
     *      if (c)
     *        2
     *      else
     *        3
     *    }
     *
     * ---- 3. ----
     *    
     *    if (b) 1
     *    else {
     *      if (c)
     *        2
     *        else 3
     *    }
     *
     *    Do the same as in number 2
     */

    if (b) {
      statement
    }
    else
      thing

    if (b)
      statement

    bare_statement

    if (b) {
      statement
    }
    else {
      thing
      that
    }

    if (statement(nested statement(another nested statement))) func(statement)
    if (statement(nested statement(another nested statement))) statement

    if (b) {
      statement
      statement
    } else if (b) {
      statement
      statement
    } else if (c) {
      statement
      statement
    } else
      dohicky

    if (b) { // comment
      statement
      statement
    } else if (b) { // comment
      statement
      statement
    } else if (c) { // comment
      statement
      statement
    } else // comment
      dohicky

    if (b)
      statement
    else {
      statement
      statement
    }

    val a = if (b) {
      10
    } else { statement }

    val a = func(
      10
    ).goThere()

    val a = func(
      10
    )

    if (b) (statement)
    else 2

    if (b) 1
    else 2

    if (b)
      1
    else if (b)
      2
    else if (b)
      2
    else
      3
    4

    if (b)
      1
    else if (b)
      2
    else
      3
    4
  }

  /**
   * This
   */
  def SomeOtherFunc = ...

  def func = {
    val reply = new Something()
    some.block {
      new X {
        statement
        statement
      }
    }
    () => goAndDo.something
  }

  def func(param: Int) = new this.Something.Or.Other(
    new SillyObject {
      override def booger() = {
        statement
        statement
      }
    },
  otherParam) // comment

  /**
   * Pulled this stuff from the fors.scala example file in the source distribution
   */
  def findNums(n: Int): Iterable[(Int, Int)] =
    for (i <- 1 until n;
         j <- 1 until (i-1);
         if isPrime(i+j)) yield (i, j)

  val books = List(
    Elem(prefix, "book", e, scope,
      Elem(prefix, "title", e, scope,
        Text("Structure and Interpretation of Computer Programs")),
      Elem(prefix, "author", e, scope,
        Text("Abelson, Harald")),
      Elem(prefix, "author", e, scope,
        Text("Sussman, Gerald J."))),
    Elem(prefix, "book", e, scope,
      Elem(prefix, "title", e, scope,
        Text("Principles of Compiler Design")),
      Elem(prefix, "author", e, scope,
        Text("Aho, Alfred")),
      Elem(prefix, "author", e, scope,
        Text("Ullman, Jeffrey"))),
    Elem(prefix, "book", e, scope,
      Elem(prefix, "title", e, scope,
        Text("Programming in Modula-2")),
      Elem(prefix, "author", e, scope,
        Text("Wirth, Niklaus")))
    )

  def mufync(statement): Int = {
    val x = function(thing)
    if (statement) func(statement)
    else func(statement)
  }

  def SomeOtherFunc = statement

  def receive = {
    case Something =>
    case OrOther =>
      here
    case There =>
  }
}
