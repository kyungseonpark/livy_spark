# Spark Image directory
spark_dir="./spark/linux_os"

cd "$spark_dir" || exit

# build spark image
docker build -t aizen_spark:j8_s323 .

# check build
if [ $? -eq 0 ]; then
    echo "Success build image"
else
    echo "Failed build image"
fi

cd "../.."


livy_dir="./livy/incubator-livy"

cd "$livy_dir" || exit

mvn clean package -B -V -e -Pspark3 -Pthriftserver -Pscala-2.12 -DskipTests -DskipITs -Dmaven.javadoc.skip=true

cd "../.."

built_dir="./livy/built_livy"

if [ -d "$built_dir" ]; then
    rm -r "$built_dir"
    echo "디렉토리를 삭제했습니다."
fi

if [ ! -d "$built_dir" ]; then
    mkdir "$built_dir"
    echo "디렉토리를 생성했습니다."
fi

built_jars="$(built_dir)/jars"
#built_rcs_jars="$(built_dir)/rcs-jars"
built_repl_jars="$(built_dir)/repl_2.12-jars"

cp "$(livy_dir)/DISCLAIMER" "$(built_dir)/"
cp "$(livy_dir)/LICENSE" "$(built_dir)/"
cp "$(livy_dir)/NOTICE" "$(built_dir)/"
cp -rf "$(livy_dir)/bin" "$(built_dir)/"
cp -rf "$(livy_dir)/conf" "$(built_dir)/"

find "$livy_dir" -name "*.jar" -exec cp {} "$built_jars" \;

#cp -rf "$(livy_dir)/conf" "$built_rcs_jars"
cp -rf "$(livy_dir)/repl/scala-2.12/target/jars/" "$built_repl_jars"

