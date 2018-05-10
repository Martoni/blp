scalaVersion := "2.11.8"

resolvers ++= Seq(
  Resolver.sonatypeRepo("snapshots"),
  Resolver.sonatypeRepo("releases")
)

libraryDependencies += "edu.berkeley.cs" %% "chisel3" % "3.1.0"

libraryDependencies += "edu.berkeley.cs" %% "firrtl" % "1.1.0"
