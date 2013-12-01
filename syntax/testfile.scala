package testfile
import java.something.com

package object SomeObject[A <: B] extends Implicits {
  type Booger[A] = A => Unit
}

class ScalaClass(i: Int = 12, b: Trait[A, Trait[B, C]]) extends B with SomeTrait[A, B[String], D] {
  val thing = "A String"
  val thing = "A String with a \" in it"
  val intString = "A string with $stuff in it"
  val intString = s"A string with $stuff and ${stuff} in it"
  val intFString = f"A string with $stuff and ${stuff} and ${eval this}%-2.2f and $stuff%2d in it"
  val otherThings = """|This is a string
                       |that spans multiple lines.
                       |""".stripMargin
  def number = 0xaf903adeL
  def float = 1f
  def float = 1F
  def float = 1.1f
  def float = 1.1F
  def float = 231.1232f
  def float = 231.2321F
  def float = .2f
  def float = .2F
  def double = 1d
  def double = 1D
  def double = 1.1d
  def double = 1.1D
  def double = 231.1232d
  def double = 231.2321D
  def double = 231.2321
  def double = .2d
  def double = .2
  def double = .2D
  def exp = 1.2342e-24
  def exp = 1e+24
  var flarf: Int = 12
  def flooger(x: String): Unit = println(42)
  private val booger = "Hithere"
  protected[this] def something[A](y: SomeTrait[A])(implicit val shoot: Function[Int, String]): Long = 12
  private final val do = done

  someVar match {
    case Flooger(thing, that, matches) =>
      flender ! Message(hi, there, guys)
  }

  try {
    whatever
  } catch {
    case e: Throwable
  } finally {
    at the end
  }

  while (a == b) {
  }

  for (x <- somecall) {
    dothing
  }

  for {
    a <- futureCall1
    b <- futureCall2
  } yield (a, b)

  protected[package] something = null

  def receive = super.receive

  require(something == true)

  val q"This $is a $string" = something

  q"""return this $thing"""
  tq"""return this $thing"""
  tq"return this $thing"
  cq"""return this $thing"""
  cq"return this $thing"
  pq"""return this $thing"""
  pq"return this $thing"

  def someFunc[A <: B, X =:= Y]
}
