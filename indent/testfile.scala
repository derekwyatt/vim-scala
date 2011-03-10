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
}
