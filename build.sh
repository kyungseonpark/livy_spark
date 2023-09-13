# Specify the directory where Livy (an Apache project) is located.
livy_dir="./livy/incubator-livy"

# Change the current working directory to the Livy directory or exit if it fails.
cd "$livy_dir" || exit

# Check out a specific Git commit (8b2e29fe9fd42c20395c63e1571f2492f005162b).
git checkout 8b2e29fe9fd42c20395c63e1571f2492f005162b

# Clean, package, and build Livy with specific Maven profiles and options.
mvn clean package -B -V -e -Pspark3 -Pthriftserver -Pscala-2.12 -DskipTests -DskipITs -Dmaven.javadoc.skip=true

# Change the current working directory back to the parent directory.
cd "../.."

# Specify the directory where Spark is located.
spark_dir="./spark/linux_os"

cp -rf "$livy_dir/thriftserver/server/target/spark"*/* "$spark_dir/rootfs/opt/aizen/spark/"

# Change the current working directory to the Spark directory or exit if it fails.
cd "$spark_dir" || exit

# Build a Docker image named "aizen_spark" with Java 8 and Spark version 3.2.3.
docker build -t aizen_spark:j8_s323 .

# Check if the Docker image build was successful or failed.
if [ $? -eq 0 ]; then
    echo "Success build image"
else
    echo "Failed build image"
fi

# Change the current working directory back to the parent directory.
cd "../.."

# Specify a directory for the built Livy artifacts.
built_dir="./livy/built_livy"

# Check if the directory exists, and if so, remove it.
if [ -d "$built_dir" ]; then
    rm -r "$built_dir"
    echo "Removed the $built_dir directory."
fi

# If the directory doesn't exist, create it.
if [ ! -d "$built_dir" ]; then
    mkdir "$built_dir"
    echo "Created the $built_dir directory."
fi

# Specify subdirectories for various Livy artifacts.
built_jars="$built_dir/jars"
built_rcs_jars="$built_dir/rsc-jars"
built_repl_jars="$built_dir/repl_2.12-jars"

# Copy certain files and directories from the Livy directory to the built directory.
cp "$livy_dir/DISCLAIMER" "$built_dir/"
cp "$livy_dir/LICENSE" "$built_dir/"
cp "$livy_dir/NOTICE" "$built_dir/"
cp -rf "$livy_dir/bin" "$built_dir/"
cp -rf "$livy_dir/conf" "$built_dir/"

# Create a directory for Livy JAR files.
mkdir "$built_jars"

# Find all JAR files in the Livy directory and copy them to the JARs directory.
find "$livy_dir" -name "*.jar" -exec cp {} "$built_jars" \;

# Create a directory for REPL JAR files.
mkdir "$built_repl_jars"

# Copy REPL JAR files from a specific location in the Livy directory to the REPL JARs directory.
cp -rf "$livy_dir/repl/scala-2.12/target/jars"/* "$built_repl_jars/"

# Create a directory for RSC JAR files.
mkdir "$built_rcs_jars"

# Copy specific JAR files related to Livy and dependencies to the RSC JARs directory.
find "$built_jars" -name "*livy-api*.jar" -exec cp {} "$built_rcs_jars" \;
find "$built_jars" -name "*livy-rsc*.jar" -exec cp {} "$built_rcs_jars" \;
find "$built_jars" -name "*livy-thriftserver*.jar" -exec cp {} "$built_rcs_jars" \;
find "$built_jars" -name "*netty-all*.jar" -exec cp {} "$built_rcs_jars" \;
